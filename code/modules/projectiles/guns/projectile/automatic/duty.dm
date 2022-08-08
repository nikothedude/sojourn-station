/obj/item/gun/projectile/automatic/duty
	name = "\"Duty\" heavy carbine"
	desc = "The Duty is a heavy carbine designed by Marshall and Blackshield gunsmiths \
	to suplement the ancient pattern boltguns as a standard issue rifle of Blackshield. \
	Having the stopping power of the Kardashev-Mosin but with a faster fire rate and less recoil. \
	The design took a lot of old world designs yet modernized it with the new caliber of 6.5mm \
	and a light polymer body balanced with heavy steel and plasteel. \
	A full production rifle, it also has melee capabilities with its bayonet \
	and it can be reloaded with a stripper clip due to the adapter guide installed on the receiver. \
	Overall a solid battle rifle for a Blackshield trooper."
	icon = 'icons/obj/guns/projectile/duty.dmi'
	icon_state = "duty"
	item_state = "duty"
	w_class = ITEM_SIZE_BULKY
	caliber = CAL_LRIFLE
	mag_well = MAG_WELL_STANMAG
	load_method = SINGLE_CASING|SPEEDLOADER|MAGAZINE
	matter = list(MATERIAL_PLASTEEL = 25, MATERIAL_PLASTIC = 25)
	price_tag = 800
	penetration_multiplier = 1.1
	init_recoil = CARBINE_RECOIL(0.9)
	fire_sound = 'sound/weapons/guns/fire/lmg_fire.ogg'
	force = WEAPON_FORCE_ROBUST
	gun_tags = list(GUN_PROJECTILE, GUN_BAYONET, GUN_SCOPE)
	init_firemodes = list(
		SEMI_AUTO_NODELAY
		)
	serial_type = "NM"

/obj/item/gun/projectile/automatic/duty/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if (ammo_magazine)
		iconstring += "[ammo_magazine? "_mag[ammo_magazine.max_ammo]": ""]"
		itemstring += "_full"

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	icon_state = iconstring
	set_item_state(itemstring)

//SNOWFLAKE CODE
//TODO make all projectile guns work like this with a flag





