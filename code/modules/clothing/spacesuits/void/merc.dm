/obj/item/clothing/head/helmet/space/void/SCAF
	name = "SCAF helmet"
	desc = "A thick airtight helmet designed for planetside warfare retrofitted with seals to act like normal space suit helmet."
	icon_state = "scaf"
	item_state = "scaf"
	armor_list = list(
		melee = 60,
		bullet = 55,
		energy = 50,
		bomb = 75,
		bio = 100,
		rad = 25
	)
	siemens_coefficient = 0.35
	species_restricted = list("Human")
	camera_networks = list(NETWORK_MERCENARY)
	light_overlay = "helmet_light_green"
	obscuration = MEDIUM_OBSCURATION
	max_upgrades = 0

/obj/item/clothing/suit/space/void/SCAF
	name = "SCAF suit"
	desc = "A bulky antique suit of refurbished infantry armour, retrofitted with seals and coatings to make it EVA capable but also reducing mobility."
	icon_state = "scaf"
	item_state = "scaf"
	slowdown = 1.3
	flags_inv = HIDEGLOVES|HIDEJUMPSUIT|HIDETAIL
	armor_list = list(
		melee = 60,
		bullet = 55,
		energy = 50,
		bomb = 75,
		bio = 100,
		rad = 25
	)
	siemens_coefficient = 0.35
	species_restricted = list("Human")
	helmet = /obj/item/clothing/head/helmet/space/void/SCAF
	price_tag = 950
	stiffness = MEDIUM_STIFFNESS
	max_upgrades = 0

/obj/item/clothing/suit/space/void/SCAF/voidwolf
	name = "REAVER-SCAF suit"
	desc = "A bulky antique suit of refurbished infantry armour, retrofitted with seals and coatings to make it EVA capable but also reducing mobility. This one has a void wolf paint job with intimidating red colors."
	icon_state = "scaf_wolf"
	item_state = "scaf_wolf"
	helmet = /obj/item/clothing/head/helmet/space/void/SCAF/voidwolf

/obj/item/clothing/head/helmet/space/void/SCAF/voidwolf
	name = "REAVER-SCAF helmet"
	desc = "A thick airtight helmet designed for planetside warfare retrofitted with seals to act like normal space suit helmet. This one has a void wolf paint job with intimidating red colors."
	icon_state = "scaf_wolf"
	item_state = "scaf_wolf"

/obj/item/clothing/head/helmet/space/void/SCAF/blackshield
	name = "blackshield SCAF helmet"
	desc = "A thick airtight helmet designed for planetside warfare retrofitted with seals to act like normal space suit helmet. Features an inbuilt camera feed and helmet light."
	icon_state = "scaf_mil"
	item_state = "scaf_mil"
	camera_networks = list(NETWORK_SECURITY)
	light_overlay = "helmet_light_white"

/obj/item/clothing/suit/space/void/SCAF/blackshield
	name = "blackshield SCAF suit"
	desc = "A bulky antique suit of refurbished into elite infantry armour, retrofitted with seals and coatings to make it EVA capable but also reducing mobility. The blackshields answers to an all purpose mobile tank suit."
	icon_state = "scaf_mil"
	item_state = "scaf_mil"
	helmet = /obj/item/clothing/head/helmet/space/void/SCAF/blackshield

//Voidsuit for traitors
/obj/item/clothing/head/helmet/space/void/merc
	name = "blood-red voidsuit helmet"
	desc = "An advanced helmet designed for work in special operations. This version is additionally reinforced against melee attacks."
	icon_state = "syndiehelm"
	item_state = "syndiehelm"
	armor_list = list(
		melee = 50,
		bullet = 40,
		energy = 30,
		bomb = 50,
		bio = 100,
		rad = 75
	)
	siemens_coefficient = 0.35
	species_restricted = list("Human")
	camera_networks = list(NETWORK_MERCENARY)
	light_overlay = "helmet_light_ihs"
	obscuration = 0

/obj/item/clothing/head/helmet/space/void/merc/update_icon()
	..()
	if(on)
		icon_state = "syndiehelm_on"
	else
		icon_state = initial(icon_state)
	return

/obj/item/clothing/suit/space/void/merc
	icon_state = "syndievoidsuit"
	name = "blood-red voidsuit"
	desc = "An advanced suit that protects against injuries during special operations. This version is additionally reinforced against melee attacks."
	item_state = "syndie_voidsuit"
	armor_list = list(
		melee = 50,
		bullet = 40,
		energy = 30,
		bomb = 50,
		bio = 100,
		rad = 75
	)
	siemens_coefficient = 0.35
	species_restricted = list("Human")
	helmet = /obj/item/clothing/head/helmet/space/void/merc
	stiffness = MEDIUM_STIFFNESS

/obj/item/clothing/suit/space/void/merc/equipped
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen

/obj/item/clothing/suit/space/void/merc/boxed
	tank = /obj/item/tank/emergency_oxygen/double

/obj/item/clothing/head/helmet/space/void/merc/xanorath
	name = "xanorath voidsuit helmet"
	desc = "A crimson helmet sporting clean lines and durable plating. Engineered to look menacing. This one is branded with a small rune at the back of the neck noting it was made by the Xanorath Syndicate."

/obj/item/clothing/suit/space/void/merc/xanorath
	name = "xanorath voidsuit"
	desc = "A crimson spacesuit sporting clean lines and durable plating. Robust, reliable, and slightly suspicious. This one is branded with a small rune at the collar noting it was made by the Xanorath Syndicate."
	helmet = /obj/item/clothing/head/helmet/space/void/merc/xanorath
	price_tag = 650


//Church Crusader armor, credit to Valterak for the original sprite.
/obj/item/clothing/head/helmet/space/void/crusader
	name = "crusader hood"
	desc = "An armored helmet with a built in light system allowing you to shine heavens grace on heretics before you purge them."
	icon_state = "inqarmor_hood"
	item_state = "inqarmor_hood"
	armor_list = list(
		melee = 65,
		bullet = 65,
		energy = 65,
		bomb = 70,
		bio = 100,
		rad = 100
	)
	siemens_coefficient = 0
	species_restricted = list("Human")
	light_overlay = "helmet_light_white"
	brightness_on = 8 //luminosity when on
	max_upgrades = 0

/obj/item/clothing/head/helmet/space/void/crusader/verb/toggle_style()
	set name = "Adjust style"
	set category = "Object"
	set src in usr

	if(!isliving(loc))
		return

	var/mob/M = usr
	var/list/options = list()
	options["standard"] = ""
	options["alternate"] = "_alt"

	var/choice = input(M,"What kind of style do you want?","Adjust Style") as null|anything in options

	if(src && choice && !M.incapacitated() && Adjacent(M))
		var/base = initial(icon_state)
		base += options[choice]
		icon_state = base
		item_state = base
		item_state_slots = null
		to_chat(M, "You change to the [choice].")
		update_icon()
		update_wear_icon()
		usr.update_action_buttons()
		return 1



/obj/item/clothing/suit/space/void/crusader
	name = "crusader 'Deus Vult' power armor"
	desc = "The church of absolutes most powerful creation, the Mark I 'Deus Vult' power armor, a void capable ablative durasteel-forged suit with built in power systems linked to a wearers cruciform, recharged by its presence to prevent slow down from the armors weight. The only thing they fear is you."
	icon_state = "inqarmor"
	item_state = "inqarmor"
	slowdown = 0
	flags_inv = HIDEGLOVES|HIDEJUMPSUIT|HIDETAIL
	armor_list = list(
		melee = 65,
		bullet = 65,
		energy = 65,
		bomb = 70,
		bio = 100,
		rad = 100
	)
	siemens_coefficient = 0
	species_restricted = list("Human")
	helmet = /obj/item/clothing/head/helmet/space/void/crusader
	max_upgrades = 0

/obj/item/clothing/suit/space/void/crusader/verb/toggle_style()
	set name = "Adjust style"
	set category = "Object"
	set src in usr

	if(!isliving(loc))
		return

	var/mob/M = usr
	var/list/options = list()
	options["standard"] = ""
	options["alternate"] = "_alt"

	var/choice = input(M,"What kind of style do you want?","Adjust Style") as null|anything in options

	if(src && choice && !M.incapacitated() && Adjacent(M))
		var/base = initial(icon_state)
		base += options[choice]
		icon_state = base
		item_state = base
		item_state_slots = null
		to_chat(M, "You change to the [choice].")
		update_icon()
		update_wear_icon()
		usr.update_action_buttons()
		return 1



/obj/item/clothing/head/helmet/space/void/peking
	name = "peking void-hat"
	desc = "A strange albiet intriguing mask and hat design. The creases at its neck are visible but the field cover appears to be attached to the air-tight mask itself. \
	It might be air-tight and fitted for space but god knows how well it actually protects the wearer.."
	icon_state = "peking"
	item_state = "peking"
	armor_list = list(
		melee = 45,
		bullet = 40,
		energy = 40,
		bomb = 25,
		bio = 100,
		rad = 50
	)
	siemens_coefficient = 0.35
	species_restricted = list("Human")
	camera_networks = list(NETWORK_MERCENARY)

/obj/item/clothing/suit/space/void/peking
	name = "peking armored fatigues"
	desc = "\"The flames blazed to the sky, death dragged its way demanding - he moved through Peking for 55 days..\" \
	A simple airtight armored suit used by Xian Jiang fighters. While the suit remains light weight in spite of its bulk one can feel by running their hand \
	along the material over the arms or lower-body section that the suit has sacrificed some of its armor coverage for mobility."
	icon_state = "peking"
	item_state = "peking"
	slowdown = 0.35
	flags_inv = HIDEGLOVES|HIDEJUMPSUIT|HIDETAIL
	armor_list = list(
		melee = 55,
		bullet = 45,
		energy = 40,
		bomb = 50,
		bio = 100,
		rad = 50
	)
	siemens_coefficient = 0.35
	species_restricted = list("Human")
	helmet = /obj/item/clothing/head/helmet/space/void/peking

/obj/item/clothing/head/helmet/space/void/ronin
	name = "\"Ronin\" Mk5 heavy voidsuit helmet"
	desc = "An advanced helmet designed specifically to shrug off blunt force blows, blades and even conventional projectiles with its domed armor design."
	icon_state = "ronin"
	item_state = "ronin"
	armor_list = list(
		melee = 66,
		bullet = 60,
		energy = 45,
		bomb = 45,
		bio = 100,
		rad = 75
	)
	siemens_coefficient = 0.35
	species_restricted = list("Human")
	camera_networks = list(NETWORK_MERCENARY)
	light_overlay = "helmet_light_ihs"
	max_upgrades = 0

/obj/item/clothing/suit/space/void/ronin
	name = "\"Ronin\" heavy voidsuit"
	desc = "\"It's the nature of time that the old ways must give in or they will die out..\" \
	The \"Ronin\" Mk V Heavy Voidsuit is a state of the art piece of technology yet hails from relatively unkown origins; sporting no corporate logos or serial numbers other than Xian Jiang markings. \
	Its armor appears to be layered to increase its thickness, protecting it from conventional small-arms projectiles. No wonder the suits nickname is 'Bulletproof Samuarai'."
	icon_state = "ronin"
	item_state = "ronin"
	slowdown = 0.45
	flags_inv = HIDEGLOVES|HIDEJUMPSUIT|HIDETAIL|HIDESHOES
	armor_list = list(
		melee = 66,
		bullet = 60,
		energy = 45,
		bomb = 45,
		bio = 100,
		rad = 75
	)
	siemens_coefficient = 0.35
	species_restricted = list("Human")
	helmet = /obj/item/clothing/head/helmet/space/void/ronin
	max_upgrades = 0

/obj/item/clothing/suit/space/void/ronin/equipped
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen

/obj/item/clothing/suit/space/void/ronin/boxed
	tank = /obj/item/tank/emergency_oxygen/double
