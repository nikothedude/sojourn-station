/obj/item/gun/energy/laser/railgun
	name = "\"Reductor\" rail rifle"
	desc = "\"Artificer's Guild\" brand rail gun. This gun features a sleek and deadly design with the capability for lethal and non-lethal firing modes. A competant engineer can also overclock it using a wrench, \
	consuming the cell within for an extra bullet or a powerful explosive round."
	icon = 'icons/obj/guns/energy/railgun.dmi'
	icon_state = "railgun"
	item_state = "railgun"
	item_charge_meter = TRUE
	fire_sound = 'sound/weapons/rail.ogg'
	item_charge_meter = TRUE
	w_class = ITEM_SIZE_BULKY
	force = WEAPON_FORCE_PAINFUL
	twohanded = TRUE
	flags = CONDUCT
	slot_flags = SLOT_BACK
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 6, TECH_ENGINEERING = 6)
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_STEEL = 8, MATERIAL_SILVER = 10)
	charge_cost = 500
	gun_tags = list(GUN_PROJECTILE, GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	suitable_cell = /obj/item/cell/large
	one_hand_penalty = 10
	fire_delay = 14 //Slow, on par with a shotgun pump then fire
	recoil_buildup = 12 //Big shots, big recoil.
	damage_multiplier = 1
	init_firemodes = list(
		list(mode_name="slug", mode_desc="fires a large metal chunk at light speeds", projectile_type=/obj/item/projectile/bullet/shotgun/railgun, icon="kill"),
		list(mode_name="non-lethal", mode_desc="fires a rubber pellet at light speed", projectile_type=/obj/item/projectile/bullet/shotgun/beanbag/railgun, icon="stun"),
		list(mode_name="grenade", mode_desc="fires an explosive synth-shell", projectile_type=/obj/item/projectile/bullet/grenade, charge_cost=30000, icon="grenade")
	)
	var/consume_cell = FALSE
	price_tag = 2250

/obj/item/gun/energy/laser/railgun/consume_next_projectile()
	if(!cell) return null
	if(!ispath(projectile_type)) return null
	if(consume_cell && !cell.checked_use(charge_cost))
		visible_message(SPAN_WARNING("\The [cell] of \the [src] burns out!"))
		qdel(cell)
		cell = null
		playsound(loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		return new projectile_type(src)
	else if(!consume_cell && !cell.checked_use(charge_cost))
		return null
	else
		return new projectile_type(src)

/obj/item/gun/energy/laser/railgun/attackby(obj/item/I, mob/user)
	..()
	if(I.has_quality(QUALITY_BOLT_TURNING))
		if(I.use_tool(user, src, WORKTIME_SLOW, QUALITY_BOLT_TURNING, FAILCHANCE_VERY_HARD, required_stat = STAT_MEC))
			if(consume_cell)
				consume_cell = FALSE
				to_chat(user, SPAN_NOTICE("You secure the safety bolts and tune down the capacitor to safe levels, preventing the weapon from destroying empty cells for use as ammuniton."))
			else
				consume_cell = TRUE
				to_chat(user, SPAN_NOTICE("You loosen the safety bolts and overclock the capacitor to unsafe levels, allowing the weapon to destroy empty cells for use as ammunition."))


/obj/item/gun/energy/laser/railgun/pistol
	name = "\"Myrmidon\" rail pistol"
	desc = "\"Artificer's Guild\" brand rail pistol. This gun features a sleek and deadly design with the capability for lethal and non-lethal firing modes. A competant engineer can also overclock it using a wrench, \
	consuming the cell within for an extra bullet or a powerful explosive round. For the law abiding engineer because rifles are too hard to hide."
	icon = 'icons/obj/guns/energy/railpistol.dmi'
	icon_state = "railpistol"
	item_state = "railpistol"
	suitable_cell = /obj/item/cell/medium
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	w_class = ITEM_SIZE_NORMAL
	force = WEAPON_FORCE_NORMAL
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 4, TECH_ENGINEERING = 4)
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_STEEL = 4, MATERIAL_SILVER = 5)
	fire_delay = 7
	charge_cost = 100
	gun_tags = list(GUN_PROJECTILE, GUN_LASER, GUN_ENERGY)
	recoil_buildup = 6 //Still a railgun.
	can_dual = TRUE
	twohanded = FALSE
	init_firemodes = list(
		list(mode_name="slug", mode_desc="fires a small metal chunk at light speeds", projectile_type=/obj/item/projectile/bullet/kurtz_50/railgun, icon="kill"),
		list(mode_name="non-lethal", mode_desc="fires a small rubber chunk at light speeds", projectile_type=/obj/item/projectile/bullet/kurtz_50/rubber/railgun, icon="stun"),
		list(mode_name="grenade", mode_desc="fires a frag synth-shell", projectile_type=/obj/item/projectile/bullet/grenade/frag, charge_cost=30000, icon="grenade"),
	)
	price_tag = 1250

/obj/item/gun/energy/shrapnel
	name = "\"Shellshock\" scrap rifle"
	desc = "A slapped together junk design made as a copy of the far superior Reductor rail gun. It's projectiles fire slower and it has a wider delay between shots with the \
	same issue of burning batteries out. The matter contained in empty cells can be converted directly into ammunition as well, if the safety bolts are loosened properly."
	icon = 'icons/obj/guns/energy/energyshotgun.dmi'
	icon_state = "eshotgun"
	item_state = "eshotgun"
	item_charge_meter = TRUE
	w_class = ITEM_SIZE_BULKY
	force = WEAPON_FORCE_PAINFUL
	gun_tags = list(GUN_PROJECTILE, GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	twohanded = TRUE
	can_dual = FALSE
	flags = CONDUCT
	slot_flags = SLOT_BACK
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_STEEL = 8)
	charge_cost = 100
	suitable_cell = /obj/item/cell/medium
	one_hand_penalty = 10
	fire_delay = 14 //Equivalent to a pump then fire time
	recoil_buildup = 1.2
	damage_multiplier = 0.8
	fire_sound = 'sound/weapons/energy_shotgun.ogg'
	init_firemodes = list(
		list(mode_name="slug", mode_desc="fires a small metal chunk at light speeds", projectile_type=/obj/item/projectile/bullet/heavy_rifle_408/railgun, icon="kill"),
		list(mode_name="grenade", mode_desc="fires a frag synth-shell", projectile_type=/obj/item/projectile/bullet/grenade/frag/weak, charge_cost=30000, icon="grenade"),
	)
	var/consume_cell = FALSE
	price_tag = 500

/obj/item/gun/energy/shrapnel/consume_next_projectile()
	if(!cell) return null
	if(!ispath(projectile_type)) return null
	if(consume_cell && !cell.checked_use(charge_cost))
		visible_message(SPAN_WARNING("\The [cell] of \the [src] burns out!"))
		qdel(cell)
		cell = null
		playsound(loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		return new projectile_type(src)
	else if(!consume_cell && !cell.checked_use(charge_cost))
		return null
	else
		return new projectile_type(src)

/obj/item/gun/energy/shrapnel/attackby(obj/item/I, mob/user)
	..()
	if(I.has_quality(QUALITY_BOLT_TURNING))
		if(I.use_tool(user, src, WORKTIME_SLOW, QUALITY_BOLT_TURNING, FAILCHANCE_VERY_HARD, required_stat = STAT_MEC))
			if(consume_cell)
				consume_cell = FALSE
				to_chat(user, SPAN_NOTICE("You secure the safety bolts and tune down the capacitor to safe levels, preventing the weapon from destroying empty cells for use as ammuniton."))
			else
				consume_cell = TRUE
				to_chat(user, SPAN_NOTICE("You loosen the safety bolts and overclock the capacitor to unsafe levels, allowing the weapon to destroy empty cells for use as ammunition."))

/obj/item/gun/energy/laser/railgun/mounted
	name = "SDF SC \"Schrapnell\""
	desc = "An energy-based railgun, employing a matter fabricator to pull shotgun rounds from thin air and energy before launching them at faster than light speeds."
	icon_state = "shrapnel"
	self_recharge = 1
	use_external_power = 1
	safety = FALSE
	restrict_safety = TRUE
	consume_cell = FALSE
	cell_type = /obj/item/cell/small/high //Two shots
	twohanded = FALSE
	init_firemodes = list(
		list(mode_name="Buckshot", mode_desc="Fires a buckshot synth-shell", projectile_type=/obj/item/projectile/bullet/pellet/shotgun, charge_cost=100, icon="kill"),
		list(mode_name="Beanbag", mode_desc="Fires a beanbag synth-shell", projectile_type=/obj/item/projectile/bullet/shotgun/beanbag, charge_cost=25, icon="stun"),
		list(mode_name="Blast", mode_desc="Fires a slug synth-shell", projectile_type=/obj/item/projectile/bullet/shotgun, charge_cost=null, icon="destroy"),
	)


//Gauss-rifle type, snowflake launcher mixed with rail rifle and hydrogen gun code. Consumes matter-stack and cell charge to fire. - Rebel0
/obj/item/gun/energy/laser/railgun/gauss
	name = "\"Bat'ko\" gauss rifle"
	desc = "A rather heavy rifle sporting a cell-loading mount, a adjustable recoil-compensating stock, a hand-crank to manually chamber the next round and a series of coils lining its front. \
	This strange gauss coil rifle has valves along the large, external coil mounts. To fire this gun it requires common venting less it overheat. \
	At the stock a large script-styled 'M' appears to be engraved into it, a form of signature from its designer along with an artificer Guild logo."
	icon = 'icons/obj/guns/energy/gauss.dmi'
	icon_state = "gauss"
	item_state = "gauss"
	fire_sound = 'sound/weapons/guns/fire/gaussrifle.ogg'
	w_class = ITEM_SIZE_HUGE
	matter = list(MATERIAL_PLASTEEL = 40, MATERIAL_SILVER = 10, MATERIAL_GOLD = 8, MATERIAL_PLATINUM = 4)
	charge_cost = 1000
	fire_delay = 30
	recoil_buildup = 30
	one_hand_penalty = 80 //guh
	zoom_factor = 1.8
	extra_damage_mult_scoped = 0.4
	damage_multiplier = 1.6
	penetration_multiplier = 1.5
	twohanded = TRUE
	slowdown_hold = 1.5
	brace_penalty = 30
	init_firemodes = list(
		list(mode_name="powered-rod", mode_desc="fires a metal rod at incredible speeds", projectile_type=/obj/item/projectile/bullet/gauss, icon="kill"),
		list(mode_name="fragmented scrap", mode_desc="fires a brittle, sharp piece of scrap-metal", projectile_type=/obj/item/projectile/bullet/grenade/frag, charge_cost=30000, icon="grenade"),
	)
	consume_cell = FALSE
	price_tag = 6000

	var/max_stored_matter = 4
	var/stored_matter = 0
	var/matter_type = MATERIAL_RSCRAP

	var/projectile_cost = 1
	var/overheat_damage = 25

	//Blacklisting upgrades currently dosnt work, - Trilby
	blacklist_upgrades = list(/obj/item/gun_upgrade/mechanism/battery_shunt,
							/obj/item/gun_upgrade/mechanism/greyson_master_catalyst)
	
	//Until blacklisting works, this will be the supliment. You get one attachment - use it wisely....... - Rebel0
	max_upgrades = 2

/obj/item/gun/energy/laser/railgun/gauss/Initialize()
	..()
	AddComponent(/datum/component/heat, COMSIG_CLICK_CTRL, TRUE,  50,  60,  20, 0.01, 2)
	RegisterSignal(src, COMSIG_HEAT_VENT, .proc/ventEvent) //this sould just be a fluff message, proc can be anything
	RegisterSignal(src, COMSIG_HEAT_OVERHEAT, .proc/handleoverheat) //this can damge the user/melt the gun/whatever. this will never proc as the gun cannot fire above the special heat threshold and the special heat threshold should be smaller than the overheat threshold
	update_icon()
	START_PROCESSING(SSobj, src)

/obj/item/gun/energy/laser/railgun/gauss/Destroy()
	STOP_PROCESSING(SSobj, src)
	..()
/obj/item/gun/energy/laser/railgun/gauss/attackby(obj/item/I, mob/user)

	if(!istype(I,/obj/item/stack/sheet))
		..()
	var/obj/item/stack/sheet/M = I
	if(istype(M) && M.name == matter_type)
		var/amount = min(M.get_amount(), round(max_stored_matter - stored_matter))
		if(M.use(amount))
			stored_matter += amount
			to_chat(usr, "You load [amount] [matter_type] into \the [src].")
	else
		return ..()

/obj/item/gun/energy/laser/railgun/gauss/consume_next_projectile(mob/user)
	if(stored_matter < projectile_cost) return null
	if(!cell) return null
	if(!ispath(projectile_type)) return null
	if(!cell.checked_use(charge_cost)) return null

	var/datum/component/heat/H = GetComponent(/datum/component/heat)
	if((H.currentHeat > H.heatThresholdSpecial ||stored_matter < projectile_cost || !..()))
		to_chat(user, "The [src] is currently overheating!")
		handleoverheat()
		return null

	stored_matter -= projectile_cost
	return new projectile_type(src)

/obj/item/gun/energy/laser/railgun/gauss/examine(user)
	. = ..()
	to_chat(user, "It holds [stored_matter]/[max_stored_matter] [matter_type].")
	to_chat(user, SPAN_NOTICE("Control-Click to manually vent this weapon's heat."))

/obj/item/gun/energy/laser/railgun/gauss/update_icon()
	cut_overlays()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if(wielded)
		itemstring += "_doble"

	icon_state = iconstring
	set_item_state(itemstring)

//Hydrogen gun snowflake variables for the Gauss
/obj/item/gun/energy/laser/railgun/gauss/proc/ventEvent()
	src.visible_message("[src]'s vents open valves atop of the exterior coil mounts, cooling itself down.")
	playsound(usr.loc, 'sound/weapons/guns/interact/gauss_vent.ogg', 50, 1)

/obj/item/gun/energy/laser/railgun/gauss/proc/handleoverheat()
	src.visible_message(SPAN_DANGER("[src] overheats, its exterior becoming blisteringly hot burning the skin down to the flesh!!"))
	var/mob/living/L = loc
	if(istype(L))
		if(L.hand == L.l_hand) // Are we using the left arm?
			L.apply_damage(overheat_damage, BURN, def_zone = BP_L_ARM)
		else // If not then it must be the right arm.
			L.apply_damage(overheat_damage, BURN, def_zone = BP_R_ARM)
