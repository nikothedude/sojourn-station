#define MOPMODE_TILE 1
#define MOPMODE_SWEEP 2

/obj/item/weapon/mop
	desc = "The world of janitalia wouldn't be complete without a mop."
	name = "mop"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "mop"
	force = WEAPON_FORCE_WEAK
	throwforce = WEAPON_FORCE_WEAK
	throw_speed = 5
	throw_range = 10
	w_class = ITEM_SIZE_NORMAL
	attack_verb = list("mopped", "bashed", "bludgeoned", "whacked")
	matter = list(MATERIAL_PLASTIC = 3)
	var/mopspeed  = 30

	var/mopmode = MOPMODE_TILE
	var/sweep_time = 7

/obj/item/weapon/mop/Initialize()
	. = ..()
	create_reagents(30)

/obj/item/weapon/mop/attack_self(var/mob/user)
	.=..()
	if (mopmode == MOPMODE_TILE)
		mopmode = MOPMODE_SWEEP
		to_chat(user, SPAN_NOTICE("You will now clean with broad sweeping motions"))
	else if (mopmode == MOPMODE_SWEEP)
		mopmode = MOPMODE_TILE
		to_chat(user, SPAN_NOTICE("You will now thoroughly clean a single tile at a time"))

/obj/item/weapon/mop/afterattack(atom/A, mob/user, proximity)
	if(!proximity) return
	if(istype(A, /turf) || istype(A, /obj/effect/decal/cleanable) || istype(A, /obj/effect/overlay))
		if(reagents.total_volume < 1)
			to_chat(user, SPAN_NOTICE("Your mop is dry!"))
			return
		var/turf/T = get_turf(A)
		if(!T)
			return
		spawn()
			user.do_attack_animation(T)
		if (mopmode == MOPMODE_TILE)
			//user.visible_message(SPAN_WARNING("[user] begins to clean \the [T]."))
			user.setClickCooldown(3)
			if(do_after(user, mopspeed, T))
				if(T)
					T.clean(src, user)
				to_chat(user, SPAN_NOTICE("You have finished mopping!"))

		//Sweep mopmode. Light and fast aoe cleaning
		else if (mopmode == MOPMODE_SWEEP)

			sweep(user, T)
	else
		makeWet(A, user)


/obj/item/weapon/mop/proc/sweep(var/mob/user, var/turf/target)
	user.setClickCooldown(sweep_time)
	var/direction = get_dir(get_turf(src),target)
	var/list/turfs
	if (direction in GLOB.cardinal)
		turfs = list(target, get_step(target,turn(direction, 90)), get_step(target,turn(direction, -90)))
	else
		turfs = list(target, get_step(target,turn(direction, 135)), get_step(target,turn(direction, -135)))

	//Lets do a fancy animation of the mop sweeping over the tiles. Code copied from attack animation
	var/turf/start = turfs[2]
	var/turf/end = turfs[3]
	var/obj/effect/effect/mopimage = new /obj/effect/effect(start)
	mopimage.appearance = appearance
	mopimage.alpha = 200
	// Who can see the attack?
	var/list/viewing = list()
	for (var/mob/M in viewers(start))
		if (M.client)
			viewing |= M.client
	//flick_overlay(I, viewing, 5) // 5 ticks/half a second
	// Scale the icon.
	mopimage.transform *= 0.75
	// And animate the attack!
	animate(mopimage, alpha = 50, time = sweep_time*1.5)
	var/sweep_step = (sweep_time - 1) * 0.5
	spawn(1)
		mopimage.forceMove(target, glide_size_override=DELAY2GLIDESIZE(sweep_step))
		sleep(sweep_step)
		mopimage.forceMove(end, glide_size_override=DELAY2GLIDESIZE(sweep_step))
	spawn(sweep_time+1)
		qdel(mopimage)

	if(!do_after(user, sweep_time,target))
		to_chat(user, SPAN_DANGER("Mopping cancelled"))
		return

	for (var/t in turfs)
		var/turf/T = t

		//Get out of the way, ankles!
		for (var/mob/living/L in T)
			attack(L)

		if (turf_clear(T))
			T.clean_partial(src, user, 1)
		else if (user)
			//You hit a wall!
			user.setClickCooldown(15)
			user.set_move_cooldown(15)
			shake_camera(user, 1, 1)
			playsound(T,"thud", 20, 1, -3)
			to_chat(user, SPAN_DANGER("There's not enough space for broad sweeps here!"))
			return

/obj/item/weapon/mop/proc/makeWet(atom/A, mob/user)
	if(A.is_open_container())
		if(A.reagents)
			if(A.reagents.total_volume < 1)
				to_chat(user, SPAN_WARNING("\The [A] is out of water!"))
				return
			A.reagents.trans_to_obj(src, reagents.maximum_volume)
		else
			reagents.add_reagent("water", reagents.maximum_volume)

		to_chat(user, SPAN_NOTICE("You wet \the [src] with \the [A]."))
		playsound(loc, 'sound/effects/slosh.ogg', 25, 1)



/obj/effect/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/mop) || istype(I, /obj/item/weapon/soap))
		return
	..()

/obj/item/weapon/mop/guild
	name = "articulated mop"
	desc = "An Artificer's Guild-modified mop. Sports a pistol-actuated mop head, a chemosynthesizer unit and a clean white finish. Uses M cells."
	icon = 'icons/obj/janitor.dmi'
	icon_state = "mop"
	force = WEAPON_FORCE_WEAK
	throwforce = WEAPON_FORCE_WEAK
	throw_speed = 5
	throw_range = 10
	w_class = ITEM_SIZE_NORMAL
	attack_verb = list("mopped", "bashed", "bludgeoned", "whacked")
	matter = list(MATERIAL_PLASTIC = 12, MATERIAL_GLASS = 4, MATERIAL_STEEL = 4)
	mopspeed  = 10
	sweep_time = 4
	var/condensing = FALSE
	var/obj/item/weapon/cell/medium/mycell

/obj/item/weapon/mop/guild/AltClick(mob/user)
	if(condensing)
		STOP_PROCESSING(SSobj, src)
	else
		START_PROCESSING(SSobj, src)
	to_chat(user, SPAN_NOTICE("You flick the condenser switch to the [condensing ? "ON" : "OFF"] position.")
	condensing = !condensing

/obj/item/weapon/mop/guild/Process()
	if(reagents.total_volume + 2 >= reagents.maximum_volume)
		src.visible_message(SPAN_NOTICE("The condenser on the [src] shuts off as its internal tank fills."))
		condensing = FALSE
		STOP_PROCESSING(SSobj, src)
		return
	else if (mycell && mycell.use(4))
		reagents.add_reagent("cleaner", 1)
		reagents.add_reagent("water", 1)

		return
	else
		src.visible_message(SPAN_NOTICE("The condenser on the [src] shuts off, battery light blinking."))
		condensing = FALSE
		STOP_PROCESSING(SSobj, src)

/obj/item/weapon/mop/guild/Initialize()
	. = ..()
	create_reagents(60)

#undef MOPMODE_TILE
#undef MOPMODE_SWEEP