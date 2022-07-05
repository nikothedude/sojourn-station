//It's a good day to die

/obj/item/gun/projectile/automatic/pulse_rifle
	name = "Pulse Rifle"
	desc = "A pulse-action air-cooled, caseless, automatic assault rifle made by an unknown manufacturer. This weapon is very rare, but deadly efficient. \
		It's used by elite mercenaries, assassins, or bald marines. Makes you feel like a space marine when you hold it."
	icon = 'icons/obj/guns/projectile/dallas.dmi'
	icon_state = "dallas"
	item_state = "dallas"
	w_class = ITEM_SIZE_HUGE
	force = WEAPON_FORCE_PAINFUL
	caliber = CAL_1024
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1)
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_PULSE
	auto_eject = 1
	matter = list(MATERIAL_PLASTEEL = 25, MATERIAL_PLASTIC = 15)
	price_tag = 2200 //99 rounds of pure pain and destruction served in auto-fire, so it basically an upgraded LMG
	fire_sound = 'sound/weapons/guns/fire/m41_shoot.ogg'
	unload_sound 	= 'sound/weapons/guns/interact/ltrifle_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/m41_reload.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/m41_cocked.ogg'
	damage_multiplier = 1
	init_recoil = LMG_RECOIL(0.7)
	gun_tags = list(GUN_PROJECTILE, GUN_SCOPE, GUN_MAGWELL)

	init_firemodes = list(
		FULL_AUTO_600,
		SEMI_AUTO_NODELAY,
		BURST_3_ROUND
		)
	serial_type = "INDEX"
	serial_shown = FALSE

/obj/item/gun/projectile/automatic/dallas/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "[initial(icon_state)]-full"
	else
		icon_state = initial(icon_state)
	return
