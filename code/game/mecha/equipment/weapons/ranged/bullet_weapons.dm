
/*
 * Contains
 * /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/scattershot
 * /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/scattershot/flak
 * /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/lmg
 * /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/lmg/scrap
 * /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/flare
 * /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/explosive
 * /obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/flashbang
 */

/obj/item/mech_ammo_box	//Should not be used by its own
	name = "ammunition box"
	desc = "Gun ammunition stored in a shiny new box. You can see caliber information on the label."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "boxhrifle-hv"
	w_class = ITEM_SIZE_BULKY
	var/ammo_amount_left = 0 //How many shells this box has left
	var/ammo_max_amout = 0 //How many shells can this big box hold?
	var/amount_per_click = 1 //how many we load per click. Used to
	var/ammo_type = "mew" //What kinda ammo do we load?
	matter = list(MATERIAL_STEEL = 35)

/obj/item/mech_ammo_box/examine(mob/user)
	..()
	to_chat(user, "<span class='info'>Ammo left: [ammo_amount_left]</span>")
	to_chat(user, "<span class='info'>Ammo type: [ammo_type]</span>")

/obj/item/mech_ammo_box/attackby(obj/item/I, mob/user as mob)
	..()
	if (istype(I, /obj/item/mech_ammo_box))
		while(1)
			if(ammo_type != src.ammo_type)
				to_chat(user, SPAN_WARNING("Wrong ammo types!"))
				return 0
			if(ammo_amount_left <= 0)
				to_chat(user, SPAN_WARNING("The box is out of ammo."))
				return 0
			if(src.ammo_max_amout <= src.ammo_amount_left)
				to_chat(user, SPAN_WARNING("The box is full."))
				return 0
			ammo_amount_left -= amount_per_click
			src.ammo_amount_left += amount_per_click
			return 1

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic
	name = "general ballisic weapon"
	var/projectile_energy_cost
	range = MECHA_MELEE | MECHA_RANGED
	var/max_ammo = 0// How much ammo can we cram into this gun?
	var/ammo_type = "mew"
	var/loaded = FALSE //do we spawn fully loaded?

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/get_equip_info()
		return "[..()]\[[src.projectiles]\]"

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/examine(mob/user)
	..()
	to_chat(user, "<span class='info'>Ammo left: [projectiles]</span>")
	to_chat(user, "<span class='info'>Ammo type: [ammo_type]</span>")

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/attackby(obj/item/I, mob/user)
	..()
	if (istype(I, /obj/item/mech_ammo_box))
		var/obj/item/mech_ammo_box/FMJ = I //Full metal jecket
		while(1)
			if(ammo_type != src.ammo_type)
				to_chat(user, SPAN_WARNING("Wrong ammo types!"))
				return 0
			if(FMJ.ammo_amount_left <= 0)
				to_chat(user, SPAN_WARNING("The box is out of ammo."))
				return 0
			if(src.max_ammo <= src.projectiles)
				to_chat(user, SPAN_WARNING("The [src] is full."))
				return 0
			FMJ.ammo_amount_left -= FMJ.amount_per_click
			src.projectiles += FMJ.amount_per_click
			return 1

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/New() //Freshly made ones are not loaded
	..()
	if(loaded)
		return
	projectiles = 0

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/Initialize() //On load we give random ammo
	..()
	if(loaded)
		return
	projectiles = clamp(-1, rand(0,max_ammo), max_ammo+1)


/obj/item/mech_ammo_box/scattershot
	name = "LBX AC 10 ammunition box"
	desc = "A box of ammo meant for loading into a LBX AC 10."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "boxhrifle-hv"
	ammo_amount_left = 40
	ammo_max_amout = 40
	ammo_type = "12g"
	price_tag = 30

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/scattershot
	name = "\improper LBX AC 10 \"Scattershot\""
	icon_state = "mecha_scatter"
	equip_cooldown = 25 // we fire fairly slow, but do a LOT of damage up close.
	matter = list(MATERIAL_STEEL = 25, MATERIAL_PLASTEEL = 15)
	projectile = /obj/item/projectile/bullet/pellet/shotgun/scattershot //snoflaek projectile. works similarly to regular shotgun rounds with 2 more pellets and 2 more damage per pellet
	fire_sound = 'sound/weapons/guns/fire/shotgunp_fire.ogg'
	fire_volume = 80
	projectiles = 40
	max_ammo = 40
	projectiles_per_shot = 1 //each 'projectile' carries 8 pellets
	fire_cooldown = 1
	deviation = 8 //kinda innacurate, but a horribly deudly firearm none the less.
	ammo_type = "12g"

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/scattershot/loaded
	loaded = TRUE

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/scattershot/flak
	name = "\improper jury-rigged flak cannon"
	desc = "The design of this weapon brings a whole new meaning to the term scrap cannon."
	icon_state = "mecha_makeshift_scatter"
	equip_cooldown = 25 //fairly slow firing, but utterly devastating against the unarmored.
	projectile = /obj/item/projectile/bullet/pellet/shotgun/flak
	fire_sound = 'sound/weapons/guns/fire/shotgunp_fire.ogg'
	fire_volume = 80
	projectiles = 30
	max_ammo = 30
	projectiles_per_shot = 3
	fire_cooldown = 0 // we fire a huge burst of pellets all over the place!
	deviation = 15 //emphasis on ALL OVER the place
	required_type = list(/obj/mecha/combat, /obj/mecha/working, /obj/mecha/working)
	price_tag = 700

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/scattershot/flak/loaded
	loaded = TRUE

/obj/item/mech_ammo_box/lmg
	name = "Ultra AC 2 ammunition box"
	desc = "Gun ammunition stored in a shiny new box. You can see caliber information on the label."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "boxhrifle-practice"
	ammo_amount_left = 300
	ammo_max_amout = 300
	amount_per_click = 3 //Hack to make them impossable to go into negitives
	ammo_type = "5.56"
	price_tag = 30

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/lmg
	name = "\improper Ultra AC 2"
	icon_state = "mecha_uac2"
	equip_cooldown = 10
	matter = list(MATERIAL_STEEL = 25, MATERIAL_PLASTEEL = 15)
	projectile = /obj/item/projectile/bullet/rifle_75
	fire_sound = 'sound/weapons/guns/fire/lmg_fire.ogg'
	projectiles = 300
	max_ammo = 300
	projectiles_per_shot = 3
	deviation = 5 //little bit innacurate, but still able to consistently lay down fire on targets
	fire_cooldown = 1.75
	ammo_type = "5.56"

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/lmg/loaded
	loaded = TRUE

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/lmg/scrap
	name = "\improper jury-rigged lead repeater"
	desc = "Few would call this weapon reliable, fewer know just how valuable it is."
	icon_state = "mecha_makeshift_uac2"
	equip_cooldown = 20
	projectile = /obj/item/projectile/bullet/pistol_35/scrap
	fire_sound = 'sound/weapons/guns/fire/smg_fire.ogg'
	projectiles = 60
	max_ammo = 60
	projectiles_per_shot = 5
	deviation = 10 //heavy deviation, its cheap casing rattles with each shot
	fire_cooldown = 3
	required_type = list(/obj/mecha/combat, /obj/mecha/working, /obj/mecha/working)

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/lmg/scrap/loaded
	loaded = TRUE

/obj/item/mech_ammo_box/cannon
	name = "Autocannon ammunition box"
	desc = "Gun ammunition stored in a shiny new box. You can see caliber information on the label."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "boxhrifle-practice"
	ammo_amount_left = 25
	ammo_max_amout = 25
	amount_per_click = 3
	ammo_type = ".460"
	price_tag = 30

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/cannon
	name = "\improper Autocannon"
	icon_state = "mecha_cannon"
	equip_cooldown = 25
	matter = list(MATERIAL_STEEL = 25, MATERIAL_PLASTEEL = 15)
	projectile = /obj/item/projectile/bullet/auto_460
	fire_sound = 'sound/weapons/guns/fire/chaingun_fire.ogg'
	projectiles = 25
	max_ammo = 25
	projectiles_per_shot = 2
	deviation = 2
	fire_cooldown = 2
	ammo_type = ".460"

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/cannon/loaded
	loaded = TRUE

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/cannon/scrap
	name = "\improper Ancient Mech Rifle"
	desc = "A weapon once wielded by anncient mechs once more finding service, however clearly showing its age."
	icon_state = "mecha_makeshift_cannon"
	equip_cooldown = 20
	projectile = /obj/item/projectile/bullet/auto_460/scrap
	fire_sound = 'sound/weapons/guns/fire/payload_fire.ogg'
	projectiles = 25
	max_ammo = 25
	projectiles_per_shot = 3
	deviation = 3
	fire_cooldown = 3.5
	required_type = list(/obj/mecha/combat, /obj/mecha/working)

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/cannon/scrap/loaded
	loaded = TRUE

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack
	var/missile_speed = 2
	var/missile_range = 30
	max_ammo = 0
	loaded = TRUE //We always start loaded
	ammo_type = "fabricated rocket"
	range = MECHA_RANGED

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/get_equip_info()
		return "[..()]\[[src.projectiles]\][(src.projectiles < initial(src.projectiles))?" - <a href='?src=\ref[src];rearm=1'>Rearm</a>":null]"

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/Fire(atom/movable/AM, atom/target)
	AM.throw_at(target,missile_range, missile_speed, chassis)

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/proc/rearm()
	if(projectiles < initial(projectiles))
		var/projectiles_to_add = initial(projectiles) - projectiles
		while(chassis.get_charge() >= projectile_energy_cost && projectiles_to_add)
			projectiles++
			projectiles_to_add--
			chassis.use_power(projectile_energy_cost)
	send_byjax(chassis.occupant,"exosuit.browser","\ref[src]",src.get_equip_info())
	log_message("Rearmed [src.name].")
	return

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/Topic(href, href_list)
	..()
	if (href_list["rearm"])
		src.rearm()
	return


/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/flare
	name = "\improper BNI Flare Launcher"
	icon_state = "mecha_flaregun"
	projectile = /obj/item/device/lighting/glowstick/flare
	fire_sound = 'sound/weapons/tablehit1.ogg'
	auto_rearm = 1
	fire_cooldown = 20
	projectiles_per_shot = 1
	projectile_energy_cost = 200
	missile_speed = 1
	missile_range = 15
	required_type = /obj/mecha  //Why restrict it to just mining or combat mechs?

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/flare/Fire(atom/movable/AM, atom/target, turf/aimloc)
	var/obj/item/device/lighting/glowstick/flare/fired = AM
	fired.turn_on()
	..()

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/explosive
	name = "\improper SRM-8 missile rack"
	icon_state = "mecha_missilerack"
	projectile = /obj/item/missile
	matter = list(MATERIAL_STEEL = 20, MATERIAL_PLASTEEL = 10, MATERIAL_SILVER = 5)
	fire_sound = 'sound/effects/bang.ogg'
	projectiles = 8
	projectile_energy_cost = 2000
	equip_cooldown = 60

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/explosive/Fire(atom/movable/AM, atom/target)
	var/obj/item/missile/M = AM
	M.primed = 1
	..()

/obj/item/missile
	icon = 'icons/obj/grenade.dmi'
	icon_state = "missile"
	var/primed = null
	throwforce = 15
	allow_spin = 0

	throw_impact(atom/hit_atom)
		if(primed)
			explosion(hit_atom, 0, 1, 2, 4, exploder = src)
			qdel(src)
		else
			..()
		return

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/flashbang
	name = "\improper SGL-6 grenade launcher"
	icon_state = "mecha_grenadelnchr"
	matter = list(MATERIAL_STEEL = 20, MATERIAL_PLASTEEL = 10)
	projectile = /obj/item/grenade/flashbang
	fire_sound = 'sound/effects/bang.ogg'
	projectiles = 6
	missile_speed = 1.5
	projectile_energy_cost = 1200
	equip_cooldown = 60
	var/det_time = 20

/obj/item/mecha_parts/mecha_equipment/ranged_weapon/ballistic/missile_rack/flashbang/Fire(atom/movable/AM, atom/target)
	..()
	var/obj/item/grenade/flashbang/F = AM
	spawn(det_time)
		F.prime()
