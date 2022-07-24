/* Drugs */
/datum/reagent/drug
	reagent_type = "Drug"
	scannable = 1

	var/sanity_gain = 0.5

/datum/reagent/drug/on_mob_add(mob/living/L)
	..()
	SEND_SIGNAL_LEGACY(L, COMSIG_CARBON_HAPPY, src, MOB_ADD_DRUG)

/datum/reagent/drug/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	if(sanity_gain)
		var/mob/living/carbon/human/H = M
		if(istype(H))
			H.sanity.onDrug(src, effect_multiplier)
		SEND_SIGNAL_LEGACY(M, COMSIG_CARBON_HAPPY, src, ON_MOB_DRUG)

/datum/reagent/drug/on_mob_delete(mob/living/L)
	..()
	SEND_SIGNAL_LEGACY(L, COMSIG_CARBON_HAPPY, src, MOB_DELETE_DRUG)

/datum/reagent/drug/space_drugs
	name = "Space drugs"
	id = "space_drugs"
	description = "An illegal chemical compound used as drug. Also a minor painkiller."
	taste_description = "bitterness"
	taste_mult = 0.4
	reagent_state = LIQUID
	color = "#60A584"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE
	addiction_chance = 100
	sanity_gain = 1.5
	illegal = TRUE

/datum/reagent/drug/space_drugs/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.druggy = max(M.druggy, 15 * effect_multiplier)
	M.add_chemical_effect(CE_PAINKILLER, 25)
	if(prob(10 * effect_multiplier) && isturf(M.loc) && !istype(M.loc, /turf/space) && M.canmove && !M.restrained())
		step(M, pick(cardinal))
	if(prob(7 * effect_multiplier))
		M.emote(pick("twitch", "drool", "moan", "giggle"))
	M.add_chemical_effect(CE_PULSE, -1)
	M.stats.addTempStat(STAT_COG, -STAT_LEVEL_BASIC, STIM_TIME, "spacedrugs")
	..()

/datum/reagent/drug/lean
	name = "antihistamine hydrochloride"
	id = "lean"
	description = "A weak sleeping agent mixed with carbondated water to make it into a drinkable substaince, but unstable in the blood. Oftin mixed with soda or coffee to get a high."
	taste_description = "bitter sweetness"
	taste_mult = 3
	reagent_state = LIQUID
	color = "#B33DE2"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE
	addiction_chance = 0 //its not an addiction they can stop at any time, its a life style!
	sanity_gain = 1.5
	illegal = TRUE
	glass_icon_state = "lean"
	glass_name = "Suspect Solo Cup"
	glass_desc = "A suspect looking solo cup of a sleeping agent mixed with soda water to be drinkable."

/datum/reagent/drug/lean/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.adjustToxLoss(2) //a strong toxin when injected
	..()

/datum/reagent/drug/lean/affect_ingest(mob/living/carbon/M, alien, effect_multiplier)
	M.sleeping = max(M.sleeping, 3) //Meant to put you to sleep but can be over powerd by coffee
	M.drowsyness = max(M.drowsyness, 20)
	M.hallucination(120, 30)
	M.druggy = max(M.druggy, 15 * effect_multiplier)
	M.add_chemical_effect(CE_PAINKILLER, 25)
	if(prob(10 * effect_multiplier) && isturf(M.loc) && !istype(M.loc, /turf/space) && M.canmove && !M.restrained())
		step(M, pick(cardinal))
	if(prob(7 * effect_multiplier))
		M.emote(pick("yawn", "drool"))
	M.add_chemical_effect(CE_PULSE, -1)
	if(sanity_gain)
		var/mob/living/carbon/human/H = M
		if(istype(H))
			H.sanity.onDrug(src, effect_multiplier)
		SEND_SIGNAL_LEGACY(M, COMSIG_CARBON_HAPPY, src, ON_MOB_DRUG)
	..()

/datum/reagent/drug/serotrotium
	name = "Serotrotium"
	id = "serotrotium"
	description = "A chemical compound that promotes concentrated production of the serotonin neurotransmitter in humans, also acts as a mild painkiller."
	taste_description = "pure happiness"
	reagent_state = LIQUID
	color = "#202040"
	metabolism = REM * 0.25
	overdose = REAGENTS_OVERDOSE
	addiction_threshold = 20
	addiction_chance = 10
	sanity_gain = 1.5

/datum/reagent/drug/serotrotium/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	if(prob(7 * effect_multiplier))
		M.emote(pick("twitch", "drool", "moan", "gasp"))
	M.add_chemical_effect(CE_PAINKILLER, 15 * effect_multiplier, TRUE)
	M.stats.addTempStat(STAT_COG, -STAT_LEVEL_BASIC, STIM_TIME, "serotrotium")
	M.stats.addTempStat(STAT_TGH, STAT_LEVEL_BASIC, STIM_TIME, "serotrotium")
	M.adjustToxLoss(-0.5)
	..()


/datum/reagent/drug/cryptobiolin
	name = "Cryptobiolin"
	id = "cryptobiolin"
	description = "Cryptobiolin causes confusion and dizziness. Acts as a painkiller."
	taste_description = "sourness"
	reagent_state = LIQUID
	color = "#000055"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE
	sanity_gain = 1
	illegal = TRUE

/datum/reagent/drug/cryptobiolin/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.make_dizzy(4 * effect_multiplier)
	M.confused = max(M.confused, 20 * effect_multiplier)
	M.add_chemical_effect(CE_PAINKILLER, 25 * effect_multiplier, TRUE)
	M.stats.addTempStat(STAT_COG, -STAT_LEVEL_BASIC, STIM_TIME, "cryptobiolin")
	M.stats.addTempStat(STAT_TGH, STAT_LEVEL_BASIC, STIM_TIME, "cryptobiolin")
	M.adjustToxLoss(-0.5)
	..()


/datum/reagent/drug/impedrezene
	name = "Impedrezene"
	id = "impedrezene"
	description = "Impedrezene is a narcotic that impedes one's ability by slowing down the higher brain cell functions, but heals the heart and numbs most pain."
	taste_description = "numbness"
	reagent_state = LIQUID
	color = "#C8A5DC"
	overdose = REAGENTS_OVERDOSE
	sanity_gain = 1
	addiction_chance = 5
	illegal = TRUE

/datum/reagent/drug/impedrezene/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.jitteriness = max(M.jitteriness - (5 * effect_multiplier), 0)
	M.add_chemical_effect(CE_PAINKILLER, 40 * effect_multiplier, TRUE)
	M.stats.addTempStat(STAT_COG, -STAT_LEVEL_ADEPT, STIM_TIME, "impedrezene")
	M.stats.addTempStat(STAT_TGH, STAT_LEVEL_ADEPT, STIM_TIME, "impedrezene")
	if(prob(80))
		M.adjustBrainLoss(0.1 * effect_multiplier)
	if(prob(50))
		M.drowsyness = max(M.drowsyness, 3 * effect_multiplier)
	if(prob(10))
		M.emote("drool")
	..()

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/internal/heart/C = H.random_organ_by_process(OP_HEART)
		if(H && istype(H))
			if(BP_IS_ROBOTIC(C))
				return
			if(C.damage > 0)
				C.damage = max(C.damage - 0.5, 0)

/datum/reagent/drug/impedrezene/withdrawal_act(mob/living/carbon/M)
	M.stats.addTempStat(STAT_ROB, STAT_LEVEL_ADEPT, STIM_TIME, "impedrezene_w")
	M.stats.addTempStat(STAT_TGH, STAT_LEVEL_ADEPT, STIM_TIME, "impedrezene_w") //UNGA!

/datum/reagent/drug/mindbreaker
	name = "Mindbreaker Toxin"
	id = "mindbreaker"
	description = "A powerful hallucinogen, it can cause fatal effects in users, stimulates cell growth."
	taste_description = "sourness"
	reagent_state = LIQUID
	color = "#B31008"
	metabolism = REM * 0.25
	addiction_chance = 30
	overdose = REAGENTS_OVERDOSE
	illegal = TRUE

/datum/reagent/drug/mindbreaker/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.hallucination(50 * effect_multiplier, 50 * effect_multiplier)
	M.druggy = max(M.druggy, 5 * effect_multiplier)
	M.make_jittery(10 * effect_multiplier)
	M.make_dizzy(10 * effect_multiplier)
	M.confused = max(M.confused, 20 * effect_multiplier)
	M.heal_organ_damage(0.1 * effect_multiplier, 0, 0.5 * effect_multiplier)
	M.add_chemical_effect(CE_BLOODCLOT, 0.15)
	M.add_chemical_effect(CE_PAINKILLER, 40 * effect_multiplier, TRUE)
	M.stats.addTempStat(STAT_COG, -STAT_LEVEL_ADEPT, STIM_TIME, "mindbreaker")
	M.stats.addTempStat(STAT_TGH, -STAT_LEVEL_ADEPT, STIM_TIME, "mindbreaker")

/datum/reagent/drug/mindbreaker/withdrawal_act(mob/living/carbon/M)
	M.stats.addTempStat(STAT_COG, STAT_LEVEL_ADEPT, STIM_TIME, "mindbreaker_w")
	M.stats.addTempStat(STAT_TGH, STAT_LEVEL_ADEPT, STIM_TIME, "mindbreaker_w")
	M.adjustToxLoss(-0.1) //Small toxins as your prossesing it out

/datum/reagent/drug/psi_juice
	name = "Cerebrix"
	id = "psi_juice"
	description = "A rare chemical originally developed by the Soteria, this quasi-stimulant enhances the mind of a psion and restores their psi essence. However its highly addictive and highly \
	dangerous if overdosed. Useless to non-psions. Has a secondary effect when drank that causes the user to enhance their cognitive abilities."
	taste_description = "ascension"
	color = "#E700E7"
	reagent_state = LIQUID
	overdose = REAGENTS_OVERDOSE
	metabolism = REM * 0.5
	addiction_chance = 90
	nerve_system_accumulations = 40
	reagent_type = "Drug/Stimulator"

/datum/reagent/drug/psi_juice/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	var/mob/living/carbon/human/H = M
	var/obj/item/organ/internal/psionic_tumor/C = H.random_organ_by_process(BP_PSION)
	var/effective_dose = dose
	if(effective_dose >= 5 && H.random_organ_by_process(BP_PSION)) //We require 5 or more
		if(C.psi_points >= C.max_psi_points)
			return
		C.psi_points += 1
		holder.remove_reagent("psi_juice", 5)

/datum/reagent/drug/psi_juice/affect_ingest(mob/living/carbon/M, alien, effect_multiplier)
	M.stats.addTempStat(STAT_COG, STAT_LEVEL_BASIC, STIM_TIME, "psi_juice")

/datum/reagent/drug/psi_juice/withdrawal_act(mob/living/carbon/M)
	M.stats.addTempStat(STAT_VIG, -STAT_LEVEL_BASIC, STIM_TIME, "psi_juice_w")

/datum/reagent/drug/psi_juice/overdose(var/mob/living/carbon/M, var/alien)
	M.add_side_effect("Headache", 11)
	M.add_chemical_effect(CE_PULSE, 2)
	M.adjustBrainLoss(0.5)

/datum/reagent/drug/psilocybin
	name = "Psilocybin"
	id = "psilocybin"
	description = "A strong psychotropic derived from certain species of mushroom. Makes the user unable to feel most pain."
	taste_description = "mushroom"
	color = "#E700E7"
	overdose = REAGENTS_OVERDOSE * 0.66
	metabolism = REM * 0.5
	addiction_chance = 10
	nerve_system_accumulations = 40
	reagent_type = "Drug/Stimulator"
	sanity_gain = 1.5

/datum/reagent/drug/psilocybin/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.druggy = max(M.druggy, 30 * effect_multiplier)
	M.add_chemical_effect(CE_PAINKILLER, 60 * effect_multiplier, TRUE)
	var/effective_dose = dose
	if(issmall(M)) effective_dose *= 2
	if(effective_dose < 1)
		M.apply_effect(3, STUTTER)
		M.make_dizzy(5)
		M.stats.addTempStat(STAT_COG, STAT_LEVEL_BASIC, STIM_TIME, "psilocybin")
		M.hallucination(50, 50)
		if(prob(5))
			M.emote(pick("twitch", "giggle"))
	else if(effective_dose < 2)
		M.apply_effect(3, STUTTER)
		M.make_jittery(5)
		M.make_dizzy(5)
		M.druggy = max(M.druggy, 35)
		if(prob(10))
			M.emote(pick("twitch", "giggle"))
	else
		M.apply_effect(3, STUTTER)
		M.make_jittery(10)
		M.make_dizzy(10)
		M.druggy = max(M.druggy, 40)
		M.stats.addTempStat(STAT_COG, STAT_LEVEL_ADEPT, STIM_TIME, "psilocybin")
		M.hallucination(100, 50)
		if(prob(15))
			M.emote(pick("twitch", "giggle"))

	..()

/datum/reagent/drug/nicotine
	name = "Nicotine"
	id = "nicotine"
	description = "A highly addictive stimulant extracted from the tobacco plant."
	taste_description = "tobacco"
	reagent_state = LIQUID
	color = "#181818"
	overdose = REAGENTS_OVERDOSE
	addiction_chance = 0 //Anything above 0 will have 100% odds when smoking
	nerve_system_accumulations = 10

/datum/reagent/drug/nicotine/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	..()
	M.add_chemical_effect(CE_PULSE, 1) //If you inject it into your blood
	M.add_chemical_effect(CE_PAINKILLER, 5)
	if(M.stats.getPerk(PERK_CHAINGUN_SMOKER))
		M.add_chemical_effect(CE_ANTITOX, 5)
		M.heal_organ_damage(0.1, 0.1)

/datum/reagent/drug/nicotine/affect_ingest(mob/living/carbon/M, alien, effect_multiplier)
	..()
	M.add_chemical_effect(CE_PAINKILLER, 5)
	if(M.stats.getPerk(PERK_CHAINGUN_SMOKER))
		M.add_chemical_effect(CE_ANTITOX, 5)
		M.heal_organ_damage(0.1, 0.1)

/datum/reagent/drug/nicotine/overdose(var/mob/living/carbon/M, var/alien)
	M.add_side_effect("Headache", 11)
	M.add_chemical_effect(CE_PULSE, 2) //You're ODing...
	if(prob(5))
		M.emote("cough")
	M.adjustOxyLoss(0.5)
	M.adjustToxLoss(0.5)

/datum/reagent/drug/nicotineplus
	name = "Fine Nicotine"
	id = "nicotineplus"
	description = "A highly addictive and strong stimulant extracted from the tobacco plant, found on the finest of cigars."
	taste_description = "fine tobacco"
	reagent_state = LIQUID
	color = "#181818"
	overdose = REAGENTS_OVERDOSE
	addiction_chance = 0 // Note: NEVER make nicotine actually addictive. EVER.
	nerve_system_accumulations = 15

/datum/reagent/drug/nicotineplus/affect_blood(mob/living/carbon/M, alien, effect_multiplier) // If you inject fine nicotine
	..()
	M.add_chemical_effect(CE_PULSE, 1)
	M.add_chemical_effect(CE_PAINKILLER, 10)
	if(M.stats.getPerk(PERK_CHAINGUN_SMOKER))
		M.add_chemical_effect(CE_ANTITOX, 10)
		M.heal_organ_damage(0.2, 0.2)

/datum/reagent/drug/nicotineplus/affect_ingest(mob/living/carbon/M, alien, effect_multiplier) // If you smoke it normally...or drink it liquid
	..()
	M.add_chemical_effect(CE_PAINKILLER, 15)
	if(M.stats.getPerk(PERK_CHAINGUN_SMOKER))
		M.add_chemical_effect(CE_ANTITOX, 10)
		M.heal_organ_damage(0.2, 0.2)

/datum/reagent/drug/nicotineplus/overdose(var/mob/living/carbon/M, var/alien)
	M.add_side_effect("Headache", 11)
	M.add_chemical_effect(CE_PULSE, 2)
	if(prob(5))
		M.emote("cough")
	M.adjustOxyLoss(1)
	M.adjustToxLoss(1)

/datum/reagent/drug/hyperzine
	name = "Hyperzine"
	id = "hyperzine"
	description = "Hyperzine is a highly effective, long lasting, muscle stimulant, but drains the body. Also promotes muscle regrowth. Will worsen injuries."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#FF3300"
	metabolism = REM * 0.2
	overdose = REAGENTS_OVERDOSE * 0.66
	withdrawal_threshold = 10
	nerve_system_accumulations = 55
	reagent_type = "Drug/Stimulator"

/datum/reagent/drug/hyperzine/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	if(prob(5))
		M.emote(pick("twitch", "blink_r", "shiver"))
	M.add_chemical_effect(CE_SPEEDBOOST, 0.6)
	M.add_chemical_effect(CE_PULSE, 2)
	M.nutrition = max(M.nutrition - 0.5 * effect_multiplier, 0)

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		//G for GUNS
		var/obj/item/organ/internal/muscle/G = H.random_organ_by_process(OP_MUSCLE)
		if(H && istype(H))
			if(BP_IS_ROBOTIC(G))
				return
			if(G.damage > 0)
				G.damage = max(G.damage - 0.5, 0)// small healing
		if(H.health <= 50)
			H.heal_organ_damage(-0.1, -0.1)

/datum/reagent/drug/hyperzine/affect_ingest(var/mob/living/carbon/M, var/alien, var/effect_multiplier)
	M.nutrition = max(M.nutrition - 1 * effect_multiplier, 0) //Drains the stomic faster

/datum/reagent/drug/hyperzine/withdrawal_act(mob/living/carbon/M)
	M.add_chemical_effect(CE_SLOWDOWN, 1)
	M.add_chemical_effect(CE_PULSE, 1)

/datum/reagent/drug/sanguinum
	name = "Sanguinum"
	id = "sanguinum"
	description = "Forces bone marrow to produce more blood than usual. Have irritating side effects"
	taste_description = "metal"
	reagent_state = LIQUID
	color = "#e06270"
	metabolism = REM
	overdose = REAGENTS_OVERDOSE/2
	nerve_system_accumulations = 40 // Was incredibly unforgiving for its effects, this makes it able to be mixed with painkillers without forcing vomit. - Seb
	addiction_chance = 30

/datum/reagent/drug/sanguinum/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.add_chemical_effect(CE_BLOODRESTORE, 1.6 * effect_multiplier)
	if(prob(2))
		spawn
			M.emote("me", 1, "coughs up blood!")
		M.drip_blood(10)

/datum/reagent/drug/sanguinum/withdrawal_act(mob/living/carbon/M)
	M.stats.addTempStat(STAT_TGH, -STAT_LEVEL_BASIC, STIM_TIME, "sanguinum_w")
	M.stats.addTempStat(STAT_COG, -STAT_LEVEL_BASIC, STIM_TIME, "sanguinum_w")
	M.stats.addTempStat(STAT_ROB, -STAT_LEVEL_BASIC, STIM_TIME, "sanguinum_w")
/*
/datum/reagent/drug/sanguinum/overdose(var/mob/living/carbon/M, var/alien)
	var/mob/living/carbon/human/H = M
	if(istype(H))
		var/list/obj/item/organ/external/bodyParts = locate(/obj/item/organ/external) in H.organs_by_name
		var/chanceToRupture = 30
		for(var/obj/item/organ/external/E in bodyParts)
			if(E.has_internal_bleeding())
				chanceToRupture -= 10
		chanceToRupture = max(0,chanceToRupture)
		//if(prob(chanceToRupture))
			//var/list/obj/item/organ/external/unluckyPart = pick(bodyParts)
			//var/datum/wound/internal_bleeding/I = new (15)
			//unluckyPart.wounds += I
*/
/datum/reagent/drug/nosfernium
	name = "Nosfernium"
	id = "nosfernium"
	description = "A chemical for when the body is bleed dry, and if its not will ensure you are left a skeleton."
	taste_description = "teeth"
	reagent_state = LIQUID
	color = "#e06270"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE/6
	nerve_system_accumulations = 80
	addiction_chance = 30

/datum/reagent/drug/nosfernium/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.add_chemical_effect(CE_NOPULSE, 1)

/datum/reagent/drug/nosfernium/withdrawal_act(mob/living/carbon/M)
	M.add_chemical_effect(CE_SLOWDOWN, 1)
	M.adjustNutrition(-25)

datum/reagent/drug/nosfernium/overdose(var/mob/living/carbon/human/M, var/alien)
	M.adjustBrainLoss(5) // This is meant to be lethal. If you survive this give your doctor a pat on the back.
