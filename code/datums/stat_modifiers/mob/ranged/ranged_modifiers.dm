/datum/stat_modifier/mob/living/carbon/superior_animal/deadeye

	inherent_projectile_mult = 2 //a little more dps, but more easily avoided
	projectile_armor_penetration_mult = 1.3

	fire_delay_increment = 1

	projectile_speed_mult = 0.85

	prefix = "Deadeye"

	description = "This one seems to be very accurate and precise with its shots. It'll likely shoot slower, but with more precision, giving it extra damage and AP."

	stattags = RANGED_STATTAG

/datum/stat_modifier/mob/living/carbon/superior_animal/triggerfinger

	rapid_adjustment = 1 //pretty noticable damage increase

	projectile_armor_penetration_mult = 0.7

	inherent_projectile_mult = 0.9

	prefix = "Trigger-fingered"

	description = "This one seems overeager to shoot. It's likely they'll fire more often than others, although with less precision, thus less armor penetration and damage."

	stattags = RANGED_STATTAG

/datum/stat_modifier/mob/living/carbon/superior_animal/quickdraw

	delayed_adjustment = -1 //instantly attacks if they see you by default

	prefix = "Quickdraw"

	description = "This one seems vigilant, especially when it comes to keeping whatever they use as a weapon at the ready. It's likely they'll react faster than others."

	stattags = RANGED_STATTAG
