/obj/item/clothing/mask/gas
	name = "gas mask"
	desc = "A face-covering mask that can be connected to an air supply. Filters harmful gases from the air."
	icon_state = "gas_mask"
	item_flags = BLOCK_GAS_SMOKE_EFFECT | AIRTIGHT
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE
	body_parts_covered = FACE|EYES
	w_class = ITEM_SIZE_NORMAL
	item_state = "gas_mask"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	siemens_coefficient = 0.9
	var/gas_filter_strength = 1			//For gas mask filters
	var/list/filtered_gases = list("plasma", "sleeping_agent")
	armor_list = list(
		melee = 0,
		bullet = 0,
		energy = 0,
		bomb = 0,
		bio = 75,
		rad = 0
	)
	price_tag = 20
	muffle_voice = TRUE

/obj/item/clothing/mask/gas/filter_air(datum/gas_mixture/air)
	var/datum/gas_mixture/filtered = new

	for(var/g in filtered_gases)
		if(air.gas[g])
			filtered.gas[g] = air.gas[g] * gas_filter_strength
			air.gas[g] -= filtered.gas[g]

	air.update_values()
	filtered.update_values()

	return filtered


/obj/item/clothing/mask/gas/verb/toggle_style()
	set name = "Adjust Style"
	set category = "Object"
	set src in usr

	if(!isliving(loc))
		return

	var/mob/M = usr
	var/list/options = list()
	options["Base"] = "gas_mask"
	options["Alternative"] = "gas_alt"
	options["Kriosan"] = "kriosan_gasmask"

	var/choice = input(M,"What kind of style do you want?","Adjust Style") as null|anything in options

	if(src && choice && !M.incapacitated() && Adjacent(M))
		icon_state = options[choice]
		to_chat(M, "You adjusted your attire's style into [choice] mode.")
		update_icon()
		update_wear_icon()
		usr.update_action_buttons()
		return 1 //Or you could just use this instead of making another subtype just for races

//Payday masks, clown alternatives, they function as gas masks.
/obj/item/clothing/mask/gas/dal
	name = "professional clown mask"
	desc = "A face-covering clown mask that hides your identity and functions as a gas mask. This one inspires great experience and cunning intelligence."
	icon_state = "dal"

/obj/item/clothing/mask/gas/wolf
	name = "psychopathic clown mask"
	desc = "A face-covering clown mask that hides your identity and functions as a gas mask. This one inspires mood shifts and a desires to use explosives."
	icon_state = "wolf"

/obj/item/clothing/mask/gas/hox
	name = "prisoner clown mask"
	desc = "A face-covering clown mask that hides your identity and functions as a gas mask. This one makes you feel as if your shackled yet always capable of escaping."
	icon_state = "hox"

/obj/item/clothing/mask/gas/cha
	name = "daredevil clown mask"
	desc = "A face-covering clown mask that hides your identity and functions as a gas mask. This one makes you feel like you should use bullets, a fuckton of bullets and probably a boot knife too."
	icon_state = "cha"

/obj/item/clothing/mask/gas/artist_hat
	name = "Spooky Rebreather"
	desc = "Wearing this makes you feel awesome - seeing someone else wearing this makes them look like a loser."
	icon_state = "artist"
	item_state = "artist_hat"
	var/list/states = list("True Form" = "artist", "The clown" = "clown",
	"The mime" = "mime", "The Feminist" = "sexyclown", "The Madman" = "joker",
	"The Rainbow Color" = "rainbow", "The Monkey" = "monkeymask", "The Owl" = "owl")
	muffle_voice = FALSE

/obj/item/clothing/mask/gas/artist_hat/attack_self(mob/user)
	var/choice = input(user, "To what form do you wish to morph this mask?","Morph Mask") as null|anything in states

	if(src && choice && !user.incapacitated() && Adjacent(user))
		icon_state = states[choice]
		to_chat(user, "Your mask has now morphed into [choice]!")
		return TRUE

/obj/item/clothing/mask/gas/clown_hat
	name = "clown wig and mask"
	desc = "A true prankster's facial attire. A clown is incomplete without their wig and mask. This one contains hologram tech that allows it to change its appearence."
	icon_state = "clown"
	item_state = "clown_hat"
	muffle_voice = FALSE

/obj/item/clothing/mask/gas/clown_hat/attack_self(mob/user)
	var/list/options = list()
	options["True Form"] = "clown"
	options["The Feminist"] = "sexyclown"
	options["The Madman"] = "joker"
	options["The Rainbow"] ="rainbow"

	var/choice = input(user, "To what form do you wish to morph this mask?","Morph Mask") as null|anything in options

	if(src && choice && !user.incapacitated() && Adjacent(user))
		icon_state = options[choice]
		to_chat(user, "Your Clown Mask has now morphed into [choice], all praise the Honk Mother!")
		return TRUE

//Plague Dr suit can be found in clothing/suits/bio.dm
/obj/item/clothing/mask/costume/history/plaguedoctor
	name = "plague doctor mask"
	desc = "A modernised version of the classic design, this mask will not only filter out plasma but it can also be connected to an air supply."
	icon_state = "plaguedoctor"
	item_state = "plaguedoctor"
	body_parts_covered = HEAD|FACE|EYES

/obj/item/clothing/mask/gas/ihs
	name = "security gasmask"
	icon_state = "IHSgasmask"
	siemens_coefficient = 0.7
	body_parts_covered = FACE|EYES
	price_tag = 40

/obj/item/clothing/mask/gas/tactical
	name = "tactical mask"
	desc = "A close-fitting tactical mask that can be connected to an air supply."
	icon_state = "swat"
	siemens_coefficient = 0.7
	price_tag = 50

/obj/item/clothing/mask/gas/germanmask
	name = "church gas mask"
	desc = "A close-fitting tactical mask that can be connected to an air supply. Best for when you need to get out of here. This one bears a small tau cross, noting it as a church branded design."
	icon_state = "germangasmask"
	siemens_coefficient = 0.7
	price_tag = 50

/obj/item/clothing/mask/gas/death_commando
	name = "death commando mask"
	icon_state = "death_commando_mask"
	item_state = "death_commando_mask"
	siemens_coefficient = 0.2

/obj/item/clothing/mask/gas/cyborg
	name = "cyborg visor"
	desc = "Beep boop."
	icon_state = "death"

//Sprite by INFRARED_BARON
/obj/item/clothing/mask/gas/big_shot
	name = "trader mask"
	desc = "A mask used by salesperson."
	icon_state = "big_shot"

//Sprite by INFRARED_BARON
/obj/item/clothing/mask/gas/colony
	name = "jester mask"
	desc = "A green wig and colourful mask to make anyone smile."
	icon_state = "colony"

/obj/item/clothing/mask/gas/industrial
	name = "industrial gas mask"
	desc = "An industrial gas mask designed for heavy usage."
	icon_state = "gas_wide"
	armor_list = list(melee = 0, bullet = 0, energy = 0, bomb = 0, bio = 80, rad = 0)

/obj/item/clothing/mask/gas/old
	name = "enviro gas mask"
	desc = "An archaic gas mask still widely available due to its mass production."
	icon_state = "gas_old"
	armor_list = list(melee = 0, bullet = 0, energy = 0, bomb = 0, bio = 70, rad = 0)

/obj/item/clothing/mask/gas/opifex
	name = "opifex gas mask"
	desc = "An archaic gas mask used commonly by opifex to filter out oxygen and other biohazards. They'll slowly die without wearing this, as will any other race that dons this mask."
	icon_state = "gas_mask_opi"
	item_state = "gas_mask_opi"
	armor_list = list(melee = 0, bullet = 0, energy = 0, bomb = 0, bio = 80, rad = 0)
	filtered_gases = list("plasma", "sleeping_agent", "oxygen")
	var/mask_open = FALSE	// Controls if the Opifex can eat through this mask
	action_button_name = "Toggle Feeding Port"

/obj/item/clothing/mask/gas/opifex/proc/feeding_port(mob/user)
	if(user.canmove && !user.stat)
		mask_open = !mask_open
		if(mask_open)
			body_parts_covered = EYES
			to_chat(user, "Your mask moves to allow you to eat.")
		else
			body_parts_covered = FACE|EYES
			to_chat(user, "Your mask moves to cover your mouth.")
	return

/obj/item/clothing/mask/gas/opifex/attack_self(mob/user)
	feeding_port(user)
	..()

/obj/item/clothing/mask/gas/opifex/alt_mask
	name = "opifex gas mask"
	desc = "An archaic gas mask is used commonly by opifex to filter out oxygen and other biohazards. This one is outfitted to more long beaks."
	icon_state = "gas_mask_opi_san"
	item_state = "gas_mask_opi_san"

/obj/item/clothing/mask/opifex_no_mask
	name = "opifex gas synthetizer"
	desc = "A newly advanced gas synthesizer is used commonly by opifex to filter oxygen from their lungs, being able to feed and eat any moment they wish with their beak exposed. They'll slowly die without wearing this, as will any other race that uses this device."
	icon_state = "gas_mask_free_beak"
	item_state = "gas_mask_free_beak"
	armor_list = list(melee = 2, bullet = 2, energy = 7, bomb = 5, bio = 0, rad = 15)
	var/list/filtered_gases = list("plasma", "sleeping_agent", "oxygen")
	var/gas_filter_strength = 1			//For gas mask filters
	item_flags = AIRTIGHT
	w_class = ITEM_SIZE_SMALL
	body_parts_covered = EYES //We only care about the eyes.
	cold_protection = 0.5 //Instead of giving gas protection, it gives you other types of protection
	heat_protection = 0.5
	gas_transfer_coefficient = 0.001
	permeability_coefficient = 0.001
	siemens_coefficient = 0.001

/obj/item/clothing/mask/opifex_no_mask/filter_air(datum/gas_mixture/air)
	var/datum/gas_mixture/filtered = new

	for(var/g in filtered_gases)
		if(air.gas[g])
			filtered.gas[g] = air.gas[g] * gas_filter_strength
			air.gas[g] -= filtered.gas[g]

	air.update_values()
	filtered.update_values()

	return filtered
