// projectile/Test has been proven to be inaccurate and doesn't use the logic behind firing a real projectile.
// impacttest uses the exact same logic, and thus, is perfectly accurate. It operates on the basis that whatever we hit will end the
// flight of the projectile, thus, showing if we can hit a target or not.

/obj/item/projectile/test/impacttest
	hitscan = TRUE
	var/list/fake_damage_types = null
	var/obj/item/projectile/reference

	var/mob_passthrough_check = 0

/obj/item/projectile/test/impacttest/launch(atom/target, angle_offset, x_offset, y_offset)

	var/turf/curloc = get_turf(src)
	var/turf/targloc = get_turf(target)

	if (!istype(targloc) || !istype(curloc))
		return TRUE

	if(targloc == curloc) //Shooting something in the same turf
		on_impact(target, TRUE)
		qdel(src)
		return FALSE

	original = target

	setup_trajectory(curloc, targloc, x_offset, y_offset, angle_offset) //plot the initial trajectory
	Process()

/obj/item/projectile/test/impacttest/Process()
	spawn while(src && src.loc)
		if(kill_count-- < 1)
			on_impact(src.loc, TRUE)
			qdel(src)
			return
		if((!( current ) || loc == current))
			current = locate(min(max(x + xo, 1), world.maxx), min(max(y + yo, 1), world.maxy), z)
		if((x == 1 || x == world.maxx || y == 1 || y == world.maxy))
			qdel(src) //this might cause issues if we dont on impact
			return

		if(has_drop_off) //Does this shot get weaker as it goes?
			//log_and_message_admins("LOG 1: range shot [range_shot] | drop ap [ap_drop_off] | drop damg | [damage_drop_off] | penetrating [penetrating].")
			range_shot++ //We get the distence form the shooter to what it hit
			damage_drop_off = max(1, range_shot - affective_damage_range) / 100 //How far we were shot - are affective range. This one is for damage drop off
			ap_drop_off = max(1, range_shot - affective_ap_range) //How far we were shot - are affective range. This one is for AP drop off

			armor_penetration = max(0, armor_penetration - ap_drop_off)

			agony = max(0, agony - range_shot) //every step we lose one agony, this stops sniping with rubbers.
			//log_and_message_admins("LOG 2| range shot [range_shot] | drop ap [ap_drop_off] | drop damg | [damage_drop_off] | penetrating [penetrating].")
			if(fake_damage_types[BRUTE])
				fake_damage_types[BRUTE] -= max(0, damage_drop_off - penetrating / 2) //1 penitration gives 25 tiles| 2 penitration 50 tiles making 0 drop

			if(fake_damage_types[BURN])
				fake_damage_types[BURN] -= max(0, damage_drop_off - penetrating / 2) //they can still embed

			if(fake_damage_types[TOX])
				fake_damage_types[TOX] -= max(0, damage_drop_off - penetrating / 2) //they can still embed

			//Clone dosnt get removed do to being rare same as o2

			if(!hitscan) //sadly cant be simulated or maybe it can im just lazy
				speed_drop_off = range_shot / 500 //How far we were shot - are affective range. This one is for speed drop off
				// Every 500 steps = 1 step delay , 50 is 0.1 (thats huge!), 5 0.01
				step_delay = step_delay + speed_drop_off

		trajectory.increment()	// increment the current location
		location = trajectory.return_location(location)		// update the locally stored location data

		if(!location)
			qdel(src)	// if it's left the world... kill it
			return

		before_move()
		Move(location.return_turf())
		pixel_x = location.pixel_x
		pixel_y = location.pixel_y

		if(!isturf(original))
			if(loc == get_turf(original))
				if(Bump(original))
					return

/obj/item/projectile/test/impacttest/on_impact(atom/A, var/false = FALSE)

	SEND_SIGNAL(src, COMSIG_TRACE_IMPACT, src, A, false)\

/obj/item/projectile/test/impacttest/Destroy()

	QDEL_NULL(reference)

	. = ..()


/obj/item/projectile/test/impacttest/Bump(atom/A, forced)

	if(A == src)
		return FALSE
	if(A == firer)
		loc = A.loc
		return FALSE //go fuck yourself in another place pls

	if((!forced) || (A in permutated))
		return FALSE

	var/passthrough = FALSE //if the projectile should continue flying
	var/distance = get_dist(starting,loc)

	var/tempLoc = get_turf(A)

	if(istype(A, /obj/structure/multiz/stairs/active))
		var/obj/structure/multiz/stairs/active/S = A
		if(S.target)
			forceMove(get_turf(S.target))
			trajectory.loc_z = loc.z
			return FALSE
	/*if(iscarbon(A))
		var/mob/living/carbon/C = A
		var/obj/item/shield/S
		for(S in get_both_hands(C))
			if(S && S.block_bullet(C, src, def_zone))
				on_hit(S,def_zone)
				qdel(src)
				return TRUE
			break //Prevents shield dual-wielding
		S = C.get_equipped_item(slot_back)
		if(S && S.block_bullet(C, src, def_zone))
			on_hit(S,def_zone)
			qdel(src)
			return TRUE*/

	if(ismob(A))
		var/mob/M = A
		if(isliving(A))
			passthrough = !attack_mob(M, distance)
		else
			passthrough = FALSE //so ghosts don't stop bullets
	else
		passthrough = (A.bullet_act(src, def_zone) == PROJECTILE_CONTINUE) //backwards compatibility
		if(isturf(A))
			for(var/obj/O in A)
				O.bullet_act(src)
			for(var/mob/living/M in A)
				attack_mob(M, distance)

	//penetrating projectiles can pass through things that otherwise would not let them
	if(!passthrough && penetrating > 0)
		if(check_penetrate(A))
			passthrough = TRUE
		penetrating--

	//the bullet passes through a dense object!
	if(passthrough)
		//move ourselves onto A so we can continue on our way
		if (!tempLoc)
			qdel(src)
			return TRUE

		loc = tempLoc
		if (A)
			permutated.Add(A)
		return FALSE

	//stop flying
	on_impact(A)

	density = FALSE
	invisibility = 101


	qdel(src)
	return TRUE

//return 1 if the projectile should be allowed to pass through after all, 0 if not.
/obj/item/projectile/test/impacttest/check_penetrate(atom/A)
	if (istype(reference, /obj/item/projectile/bullet))
		if(!A || !A.density)
			return TRUE //if whatever it was got destroyed when we hit it, then I guess we can just keep going

		if(istype(A, /obj/mecha))
			return TRUE //mecha have their own penetration handling
		var/damage = fake_damage_types[BRUTE]
		if(ismob(A))
			if(!mob_passthrough_check)
				return FALSE
			if(iscarbon(A))
				damage *= 0.7
			return TRUE

		var/chance = 0
		if(istype(A, /turf/simulated/wall))
			var/turf/simulated/wall/W = A
			chance = round(damage/W.material.integrity*180)
		else if(istype(A, /obj/machinery/door))
			var/obj/machinery/door/D = A
			chance = round(damage/D.maxHealth*180)
			if(D.glass)
				chance *= 2
		else if(istype(A, /obj/structure/girder))
			chance = 100
		else if(istype(A, /obj/machinery) || istype(A, /obj/structure))
			chance = damage

		if(prob(chance))
			return TRUE

		return FALSE
	else
		return TRUE

/obj/item/projectile/proc/attack_mob(mob/living/target_mob, distance, miss_modifier=0)
	if(!istype(target_mob))
		return

	if(target_mob == firer) // Do not hit the shooter if the bullet hasn't ricocheted yet. The firer changes upon ricochet, so this should not prevent ricocheting shots from hitting their shooter.
		return FALSE

	//roll to-hit
	miss_modifier = 0
	var/hit_zone = check_zone(def_zone)

	var/result = PROJECTILE_FORCE_MISS
	if(hit_zone)
		def_zone = hit_zone //set def_zone, so if the projectile ends up hitting someone else later (to be implemented), it is more likely to hit the same part
		if(def_zone)
			switch(target_mob.dir)
				if(2)
					if(p_y <= 10) //legs level
						if(p_x  >= 17)
							if(def_zone == BP_L_LEG || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_L_ARM \
							|| def_zone == BP_CHEST)
								def_zone = BP_L_LEG
							if(def_zone == BP_HEAD || def_zone == BP_R_ARM)
								def_zone = BP_CHEST
							//lleg
						else
							if(def_zone == BP_L_LEG || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST)
								def_zone = BP_R_LEG
							if(def_zone == BP_HEAD || def_zone == BP_L_ARM)
								def_zone = BP_CHEST
							//rleg
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_L_LEG, BP_R_LEG)

					if(p_y > 10 && p_y <= 13) //groin level
						if(p_x <= 12)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_R_ARM
							if(def_zone == BP_HEAD || def_zone == BP_L_LEG)
								def_zone = BP_CHEST
							//rarm
						if(p_x > 12 && p_x < 21)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_L_LEG)
								def_zone = BP_GROIN
							if(def_zone == BP_HEAD)
								def_zone = BP_CHEST
							//groin
						if(p_x >= 21 && p_x < 24)
							//larm
							if(def_zone == BP_L_ARM || def_zone == BP_L_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_L_ARM
							if(def_zone == BP_HEAD || def_zone == BP_R_LEG)
								def_zone = BP_CHEST

						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST, BP_GROIN)

					if(p_y > 13 && p_y <= 22)
						if(p_x <= 12)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_R_ARM
							if(def_zone == BP_HEAD || def_zone == BP_L_LEG)
								def_zone = BP_CHEST
							//rarm
						if(p_x > 12 && p_x < 21)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_L_LEG \
							|| def_zone == BP_HEAD)
								def_zone = BP_CHEST
							//chest

						if(p_x >= 21 && p_x < 24)
							if(def_zone == BP_L_ARM || def_zone == BP_HEAD\
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_L_LEG)
								def_zone = BP_L_ARM
							//larm
							if(def_zone == BP_HEAD || def_zone == BP_R_LEG)
								def_zone = BP_CHEST

						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST)

					if(p_y > 22 && p_y <= 32)
						if(def_zone == BP_L_ARM \
						|| def_zone == BP_R_ARM \
						|| def_zone == BP_CHEST)
							def_zone = BP_HEAD
						//head
						if(def_zone == BP_GROIN || def_zone == BP_R_LEG || \
						def_zone == BP_L_LEG)
							def_zone = BP_CHEST

						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_HEAD, BP_CHEST)
				if(1)
					if(p_y <= 10) //legs level
						if(p_x  >= 17)
							if(def_zone == BP_L_LEG || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST)
								def_zone = BP_R_LEG
							if(def_zone == BP_HEAD || def_zone == BP_L_ARM)
								def_zone = BP_CHEST
							//rleg

						else
							if(def_zone == BP_L_LEG || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_L_ARM \
							|| def_zone == BP_CHEST)
								def_zone = BP_L_LEG
							if(def_zone == BP_HEAD || def_zone == BP_L_ARM)
								def_zone = BP_CHEST
							//lleg
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_LEG, BP_L_LEG, BP_CHEST)

					if(p_y > 10 && p_y <= 13) //groin level
						if(p_x <= 12)
							if(def_zone == BP_L_ARM || def_zone == BP_L_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_L_ARM
							if(def_zone == BP_HEAD || def_zone == BP_R_LEG)
								def_zone = BP_CHEST
							//larm
						if(p_x > 12 && p_x < 21)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_L_LEG)
								def_zone = BP_GROIN
							if(def_zone == BP_HEAD)
								def_zone = BP_CHEST
							//groin
						if(p_x >= 21 && p_x < 24)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_R_ARM
							if(def_zone == BP_HEAD || def_zone == BP_L_LEG)
								def_zone = BP_CHEST
							//rarm
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST, BP_GROIN)
					if(p_y > 13 && p_y <= 22)
						if(p_x <= 12)
							if(def_zone == BP_L_ARM || def_zone == BP_L_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_L_ARM
							if(def_zone == BP_HEAD || def_zone == BP_R_LEG)
								def_zone = BP_CHEST
							//larm
						if(p_x > 12 && p_x < 21)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_L_LEG \
							|| def_zone == BP_HEAD)
								def_zone = BP_CHEST
							if(def_zone == BP_HEAD || def_zone == BP_R_LEG)
								def_zone = BP_CHEST
							//chest
						if(p_x >= 21 && p_x < 24)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_R_ARM
							if(def_zone == BP_HEAD || def_zone == BP_L_LEG)
								def_zone = BP_CHEST
							//rarm
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST)

					if(p_y > 22 && p_y <= 32)
						if(def_zone == BP_L_ARM \
						|| def_zone == BP_R_ARM \
						|| def_zone == BP_CHEST)
							def_zone = BP_HEAD
						if(def_zone == BP_GROIN || def_zone == BP_L_LEG || \
						def_zone == BP_R_LEG)
							def_zone = BP_CHEST
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST, BP_HEAD)
						//head
				if(4)
					if(p_y <= 10) //legs level
						if(def_zone == BP_R_LEG \
						|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
						|| def_zone == BP_CHEST)
							def_zone = BP_R_LEG
						if(def_zone == BP_HEAD || def_zone == BP_R_ARM)
							def_zone = BP_CHEST
						if(def_zone == BP_L_LEG)
							def_zone = BP_L_LEG
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_LEG, BP_L_LEG, BP_CHEST)
						//rleg

					if(p_y > 10 && p_y <= 13) //groin level
						if(p_x < 16)
							if(def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_R_ARM
							if(def_zone == HEAD || def_zone == BP_L_LEG)
								def_zone = BP_CHEST
							if(def_zone == BP_L_ARM)
								def_zone = BP_L_ARM
							//rarm
						if(p_x >= 16)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_L_LEG)
								def_zone = BP_GROIN
							if(def_zone == BP_HEAD)
								def_zone = BP_CHEST

						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST, BP_GROIN)
							//groin

					if(p_y > 13 && p_y <= 22)
						if(p_x >= 16)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_L_LEG \
							|| def_zone == HEAD)
								def_zone = BP_CHEST
							//chest
						if(p_x < 16)
							if(def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_R_ARM
							//rarm
							if(def_zone == BP_HEAD || def_zone == BP_L_LEG)
								def_zone = BP_CHEST
							if(def_zone == BP_L_ARM)
								def_zone = BP_L_ARM
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST)

					if(p_y > 22 && p_y <= 32)
						if(def_zone == BP_L_ARM \
						|| def_zone == BP_R_ARM \
						|| def_zone == BP_CHEST)
							def_zone = BP_HEAD
						if(def_zone ==  BP_GROIN || def_zone == BP_L_LEG || def_zone == BP_R_LEG)
							def_zone = BP_CHEST
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST, BP_HEAD)
						//head

				if(8)
					if(p_y <= 10) //legs level
						//lleg
						if(def_zone == BP_L_LEG \
						|| def_zone == BP_GROIN || def_zone == BP_L_ARM \
						|| def_zone == BP_CHEST)
							def_zone = BP_L_LEG

						if(def_zone == BP_HEAD || def_zone == BP_R_ARM)
							def_zone = BP_CHEST

						if(def_zone == BP_R_LEG)
							def_zone = BP_R_LEG
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_LEG, BP_L_LEG, BP_CHEST)

					if(p_y > 10 && p_y <= 13) //groin level
						if(p_x < 16)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_L_LEG)
								def_zone = BP_GROIN
							if(def_zone == BP_HEAD)
								def_zone = BP_CHEST
							//groin
						if(p_x >= 16)
							if(def_zone == BP_L_ARM || def_zone == BP_L_LEG \
							|| def_zone == BP_GROIN \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_L_ARM
							if(def_zone == BP_HEAD || def_zone == BP_R_LEG)
								def_zone = BP_CHEST
							if(def_zone == BP_R_ARM)
								def_zone = BP_R_ARM
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST, BP_GROIN)
							//left_arm

					if(p_y > 13 && p_y <= 22)
						if(p_x < 16)
							if(def_zone == BP_L_ARM || def_zone == BP_R_LEG \
							|| def_zone == BP_GROIN || def_zone == BP_R_ARM \
							|| def_zone == BP_CHEST || def_zone == BP_L_LEG \
							|| def_zone == BP_HEAD)
								def_zone = BP_CHEST
							//chest
						if(p_x >= 16)
							if(def_zone == BP_L_ARM || def_zone == BP_L_LEG \
							|| def_zone == BP_GROIN \
							|| def_zone == BP_CHEST || def_zone == BP_HEAD)
								def_zone = BP_L_ARM
							if(def_zone == BP_R_LEG || def_zone == BP_HEAD)
								def_zone = BP_CHEST
							if(def_zone == BP_R_ARM)
								def_zone = BP_R_ARM
							//larm
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST)

					if(p_y > 22 && p_y <= 32)
						if(def_zone == BP_L_ARM \
						|| def_zone == BP_R_ARM \
						|| def_zone == BP_CHEST)
							def_zone = BP_HEAD
						if(def_zone ==  BP_GROIN || def_zone == BP_L_LEG || def_zone == BP_R_LEG)
							def_zone = BP_CHEST
						if(istargetloc(target_mob) == 0)
							def_zone = pick(BP_R_ARM, BP_L_ARM, BP_CHEST, BP_HEAD)
						//head



			result = target_mob.bullet_act(src, def_zone)//this returns mob's armor_check and another - see modules/mob/living/living_defense.dm


	if(result == PROJECTILE_FORCE_MISS)
		if(!silenced)
			visible_message(SPAN_NOTICE("\The [src] misses [target_mob] narrowly!"))
		return FALSE

	//hit messages
	if(silenced)
		to_chat(target_mob, SPAN_DANGER("You've been hit in the [parse_zone(def_zone)] by \the [src]!"))
	else
		visible_message(SPAN_DANGER("\The [target_mob] is hit by \the [src] in the [parse_zone(def_zone)]!"))//X has fired Y is now given by the guns so you cant tell who shot you if you could not see the shooter

	playsound(target_mob, pick(mob_hit_sound), 40, 1)

	//admin logs
	if(!no_attack_log)
		if(ismob(firer))

			var/attacker_message = "shot with \a [src.type]"
			var/victim_message = "shot with \a [src.type]"
			var/admin_message = "shot (\a [src.type])"

			admin_attack_log(firer, target_mob, attacker_message, victim_message, admin_message)
		else
			target_mob.attack_log += "\[[time_stamp()]\] <b>UNKNOWN SUBJECT (No longer exists)</b> shot <b>[target_mob]/[target_mob.ckey]</b> with <b>\a [src]</b>"
			msg_admin_attack("UNKNOWN shot [target_mob] ([target_mob.ckey]) with \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[target_mob.x];Y=[target_mob.y];Z=[target_mob.z]'>JMP</a>)")

	//sometimes bullet_act() will want the projectile to continue flying
	if (result == PROJECTILE_CONTINUE)
		return FALSE

	if(target_mob.mob_classification & CLASSIFICATION_ORGANIC)
		var/turf/target_loca = get_turf(target_mob)
		var/mob/living/L = target_mob
		if(damage_types[BRUTE] > 10)
			var/splatter_dir = dir
			if(starting)
				splatter_dir = get_dir(starting, target_loca)
				target_loca = get_step(target_loca, splatter_dir)
			var/blood_color = "#C80000"
			if(ishuman(target_mob))
				var/mob/living/carbon/human/H = target_mob
				blood_color = H.form.blood_color
			new /obj/effect/overlay/temp/dir_setting/bloodsplatter(target_mob.loc, splatter_dir, blood_color)
			if(target_loca && prob(50))
				target_loca.add_blood(L)

	return TRUE


/proc/check_trajectory_raytrace(var/atom/movable/target, var/atom/movable/firer, var/obj/item/projectile/proj_reference, var/signal_handler = proc/handle_trace_impact)

	if(!istype(target) || !istype(firer))
		return FALSE

	var/obj/item/projectile/test/impacttest/trace = new /obj/item/projectile/test/impacttest/(get_turf(firer)) //Making the test....
	trace.reference = proj_reference
	trace.pass_flags = proj_reference.pass_flags
	trace.flags = proj_reference.flags
	trace.penetrating = proj_reference.penetrating
	trace.fake_damage_types = proj_reference.damage_types
	trace.kill_count = proj_reference.kill_count
	trace.has_drop_off = proj_reference.has_drop_off
	trace.affective_ap_range = proj_reference.affective_ap_range
	trace.affective_damage_range = proj_reference.affective_damage_range
	if (istype(proj_reference, /obj/item/projectile/bullet))
		var/obj/item/projectile/bullet/proj = proj_reference
		trace.mob_passthrough_check = proj.mob_passthrough_check

	firer.RegisterSignal(trace, COMSIG_TRACE_IMPACT, signal_handler)
	trace.launch(target)

/proc/handle_trace_impact(var/obj/item/projectile/test/impacttest/trace, var/atom/impact_atom, var/false = FALSE)
	SIGNAL_HANDLER

	return FALSE
