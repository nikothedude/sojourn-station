/mob/living
	see_in_dark = 2
	see_invisible = SEE_INVISIBLE_LIVING

	//Health and life related vars
	maxHealth = 100 //Maximum health that should be possible.
	health = 100 	//A mob's health

	var/hud_updateflag = 0

	var/life_cycles_before_sleep = 60
	var/life_cycles_before_scan = 360

	var/stasis = FALSE
	var/AI_inactive = FALSE

	var/inventory_shown = 1

	//Damage related vars, NOTE: THESE SHOULD ONLY BE MODIFIED BY PROCS
	var/bruteloss = 0.0	//Brutal damage caused by brute force (punching, being clubbed by a toolbox ect... this also accounts for pressure damage)
	var/oxyloss = 0.0	//Oxygen depravation damage (no air in lungs)
	var/toxloss = 0.0	//Toxic damage caused by being poisoned or radiated
	var/fireloss = 0.0	//Burn damage caused by being way too hot, too cold or burnt.
	var/cloneloss = 0	//Damage caused by being cloned or ejected from the cloner early. slimes also deal cloneloss damage to victims
	var/brainloss = 0	//'Retardation' damage caused by someone hitting you in the head with a bible or being infected with brainrot.
	var/halloss = 0		//Hallucination damage. 'Fake' damage obtained through hallucinating or the holodeck. Sleeping should cause it to wear off.

	var/last_special = 0 //Used by the resist verb, likely used to prevent players from bypassing next_move by logging in/out.

	var/t_plasma = null
	var/t_oxygen = null
	var/t_sl_gas = null
	var/t_n2 = null

	var/now_pushing = null
	var/mob_bump_flag = 0
	var/mob_swap_flags = 0
	var/mob_push_flags = 0
	var/mob_always_swap = 0
	var/move_to_delay = 4 //delay for the automated movement.
	var/livmomentum = 0 //Used for advanced movement options.
	var/can_burrow = FALSE //If true, this mob can travel around using the burrow network.
	//When this mob spawns at roundstart, a burrow will be created near it if it can't find one

	var/mob/living/cameraFollow = null
	var/list/datum/action/actions = list()
	var/step_count = 0

	var/tod = null // Time of death
	var/update_slimes = 1
	var/is_busy = FALSE // Prevents stacking of certain actions, like resting and diving
	var/silent = 0 		// Can't talk. Value goes down every life proc.
	var/on_fire = 0 //The "Are we on fire?" var
	var/fire_stacks
	var/next_onfire_hal = 0 //burn

	var/failed_last_breath = 0 //This is used to determine if the mob failed a breath. If they did fail a brath, they will attempt to breathe each tick, otherwise just once per 4 ticks.
	var/possession_candidate // Can be possessed by ghosts if unplayed.

	var/eye_blind = 0	//Carbon
	var/eye_blurry = 0	//Carbon
	var/ear_damage = 0	//Carbon
	var/stuttering = 0	//Carbon
	var/slurring = 0	//Carbon
	var/slowdown = 0
	var/job = null//Living

	var/image/static_overlay // For static over-lays on living mobs
	mob_classification = CLASSIFICATION_ORGANIC

	var/list/chem_effects = list()

	//Inactive Mutations populated at spawn, meant to reflect integral parts of this creature's DNA
	var/list/inherent_mutations = list()

	//Mutations populated through horrendous genetic tampering.
	var/datum/genetics/genetics_holder/unnatural_mutations

	//How much material is used by the cloning process
	var/clone_difficulty = CLONE_MEDIUM

	var/is_watching = TRUE  //used for remote viewing of multiz structures
	var/can_multiz_pb = FALSE // used for point-blanking people that camp ladders.

	//Used in living/recoil.dm
	var/recoil = 0 //What our current recoil level is
	var/recoil_reduction_timer
	var/falls_mod = 1
	var/mob_bomb_defense = 0	// protection from explosives
	var/mod_climb_delay = 1 // delay for climb
	var/noise_coeff = 1 //noise coefficient
	var/brute_mod_perk = 1 //this and the ones below adjust various damages via perks
	var/burn_mod_perk = 1
	var/toxin_mod_perk = 1
	var/oxy_mod_perk = 1

	var/list/drop_items = list() //Held items a creature can drop when they die. Accessed through drop_death_loot()