/*Ties*/

/obj/item/clothing/accessory
	name = "blue tie"
	desc = "A neosilk clip-on tie with a blue design."
	icon = 'icons/inventory/accessory/icon.dmi'
	icon_state = "bluetie"
	item_state = ""	//no inhands
	slot_flags = SLOT_ACCESSORY_BUFFER
	w_class = ITEM_SIZE_SMALL
	var/slot = "decor"
	var/obj/item/clothing/has_suit = null		//the suit the tie may be attached to
	var/image/inv_overlay = null	//overlay used when attached to clothing.
	var/image/mob_overlay = null
	var/overlay_state = null

/obj/item/clothing/accessory/Destroy()
	if(has_suit)
		on_removed()
	return ..()

/obj/item/clothing/accessory/proc/get_inv_overlay()
	if(!inv_overlay)
		if(!mob_overlay)
			get_mob_overlay()

		var/tmp_icon_state = "[overlay_state? "[overlay_state]" : "[icon_state]"]"
		if(icon_override)
			if("[tmp_icon_state]_tie" in icon_states(icon_override))
				tmp_icon_state = "[tmp_icon_state]_tie"
		inv_overlay = image(icon = mob_overlay.icon, icon_state = tmp_icon_state, dir = SOUTH)
	return inv_overlay

/obj/item/clothing/accessory/proc/get_mob_overlay()
	if(!mob_overlay)
		var/tmp_icon_state = "[overlay_state? "[overlay_state]" : "[icon_state]"]"
		if(icon_override)
			if("[tmp_icon_state]_mob" in icon_states(icon_override))
				tmp_icon_state = "[tmp_icon_state]_mob"
			mob_overlay = image("icon" = icon_override, "icon_state" = "[tmp_icon_state]")
		else
			mob_overlay = image("icon" = INV_ACCESSORIES_DEF_ICON, "icon_state" = "[tmp_icon_state]")
	return mob_overlay

//when user attached an accessory to S
/obj/item/clothing/accessory/proc/on_attached(var/obj/item/clothing/S, var/mob/user)
	if(!istype(S))
		return
	has_suit = S
	loc = has_suit
	has_suit.add_overlay(get_inv_overlay())

	to_chat(user, SPAN_NOTICE("You attach \the [src] to \the [has_suit]."))
	src.add_fingerprint(user)

/obj/item/clothing/accessory/proc/on_removed(var/mob/user)
	if(!has_suit)
		return
	has_suit.cut_overlay(get_inv_overlay())
	has_suit = null
	if(user)
		usr.put_in_hands(src)
		src.add_fingerprint(user)
	else
		src.forceMove(get_turf(src))

//default attackby behaviour
/obj/item/clothing/accessory/attackby(obj/item/I, mob/user)
	..()

//default attack_hand behaviour
/obj/item/clothing/accessory/attack_hand(mob/user as mob)
	if(has_suit)
		return	//we aren't an object on the ground so don't call parent
	..()

/obj/item/clothing/accessory/tie/black
	name = "black tie"
	desc = "A neosilk clip-on tie with a black design."
	icon_state = "blacktie"

/obj/item/clothing/accessory/tie/blue
	name = "blue tie"
	desc = "A neosilk clip-on tie with a blue design."
	icon_state = "bluetie"

/obj/item/clothing/accessory/tie/blueclip
	name = "blue clip tie"
	desc = "A neosilk clip-on tie with a striped blue design and clip."
	icon_state = "bluecliptie"

/obj/item/clothing/accessory/tie/bluestriped
	name = "blue striped tie"
	desc = "A neosilk clip-on tie with a striped blue design."
	icon_state = "bluelongtie"

/obj/item/clothing/accessory/tie/darkgreen
	name = "dark green tie"
	desc = "A neosilk clip-on tie with a dark green design."
	icon_state = "dgreentie"

/obj/item/clothing/accessory/tie/navy
	name = "navy tie"
	desc = "A neosilk clip-on tie with a navy design."
	icon_state = "navytie"

/obj/item/clothing/accessory/tie/red
	name = "red tie"
	desc = "A neosilk clip-on tie with a red design."
	icon_state = "redtie"

/obj/item/clothing/accessory/tie/redclip
	name = "red clip tie"
	desc = "A neosilk clip-on tie with a striped red design and clip."
	icon_state = "redcliptie"

/obj/item/clothing/accessory/tie/redstriped
	name = "red striped tie"
	desc = "A neosilk clip-on tie with a striped red design."
	icon_state = "redlongtie"

/obj/item/clothing/accessory/tie/white
	name = "white tie"
	desc = "A neosilk clip-on tie with a white design."
	icon_state = "whitetie"

/obj/item/clothing/accessory/tie/yellow
	name = "yellow tie"
	desc = "A neosilk clip-on tie with a yellow design."
	icon_state = "yellowtie"

/obj/item/clothing/accessory/tie
	name = "yellow large tie"
	desc = "A neosilk clip-on tie with a gaudy yellow design."
	icon_state = "horribletie"

/*Stethoscope*/

/obj/item/clothing/accessory/stethoscope
	name = "stethoscope"
	desc = "An outdated medical apparatus for listening to the sounds of the human body. It also makes you look like you know what you're doing."
	icon_state = "stethoscope"

/obj/item/clothing/accessory/stethoscope/attack(mob/living/carbon/human/M, mob/living/user)
	// TODO: baymed, rework this to use something like get_heartbeat()
	if(ishuman(M) && isliving(user))
		if(user.a_intent == I_HELP)
			var/body_part = parse_zone(user.targeted_organ)
			if(body_part)
				var/their = "their"
				switch(M.gender)
					if(MALE)	their = "his"
					if(FEMALE)	their = "her"

				var/sound = "heartbeat"
				var/sound_strength = "cannot hear"
				var/heartbeat = 0
				if(M.species && M.species.has_process[OP_HEART])
					var/obj/item/organ/internal/heart/heart = M.random_organ_by_process(OP_HEART)
					if(heart && !BP_IS_ROBOTIC(heart))
						heartbeat = 1
				if(M.stat == DEAD || (M.status_flags&FAKEDEATH))
					sound_strength = "cannot hear"
					sound = "anything"
				else
					switch(body_part)
						if(BP_CHEST)
							sound_strength = "hear"
							sound = "no heartbeat"
							if(heartbeat)
								var/obj/item/organ/internal/heart/heart = M.random_organ_by_process(OP_HEART)
								if(!heart)
									return
								if(heart.is_bruised() || M.getOxyLoss() > 50)
									sound = "[pick("odd noises in","weak")] heartbeat"
								else
									sound = "healthy heartbeat"

							if(!(M.organ_list_by_process(OP_LUNGS).len) || M.losebreath)
								sound += " and no respiration"
							else if(M.is_lung_ruptured() || M.getOxyLoss() > 50)
								sound += " and [pick("wheezing","gurgling")] sounds"
							else
								sound += " and healthy respiration"
						if(BP_EYES, BP_MOUTH)
							sound_strength = "cannot hear"
							sound = "anything"
						else
							if(heartbeat)
								sound_strength = "hear a weak"
								sound = "pulse"

				user.visible_message("[user] places [src] against [M]'s [body_part] and listens attentively.", "You place [src] against [their] [body_part]. You [sound_strength] [sound].")
	return ..(M,user)

/*Medals*/

/obj/item/clothing/accessory/medal
	name = "bronze medal"
	desc = "A bronze medal."
	icon_state = "bronze"
	price_tag = 250

/obj/item/clothing/accessory/medal/conduct
	name = "distinguished conduct medal"
	desc = "A bronze medal awarded for distinguished conduct. Whilst a great honor, this is most basic award on offer. It is often awarded by the council to a member of their crew."

/obj/item/clothing/accessory/medal/bronze_heart
	name = "bronze heart medal"
	desc = "A bronze heart-shaped medal awarded for sacrifice. It is often awarded posthumously or for severe injury in the line of duty."
	icon_state = "bronze_heart"

/obj/item/clothing/accessory/medal/nobel_science
	name = "nobel sciences award"
	desc = "A bronze medal which represents significant contributions to the field of science or engineering."

/obj/item/clothing/accessory/medal/silver
	name = "silver medal"
	desc = "A silver medal."
	icon_state = "silver"
	price_tag = 250

/obj/item/clothing/accessory/medal/silver/valor
	name = "medal of valor"
	desc = "A silver medal awarded for acts of exceptional valor."

/obj/item/clothing/accessory/medal/silver/security
	name = "robust security award"
	desc = "An award for distinguished combat and sacrifice in defence of the colony. Often awarded to security staff."

/obj/item/clothing/accessory/medal/gold
	name = "gold medal"
	desc = "A prestigious golden medal."
	icon_state = "gold"
	price_tag = 500

/obj/item/clothing/accessory/medal/gold/captain
	name = "medal of exceptional statecraft"
	desc = "A golden medal awarded exclusively to those who show distinguished duty as a premier. It signifies the codified responsibilities of the position and their undisputable qualities within it."

/obj/item/clothing/accessory/medal/gold/heroism
	name = "medal of exceptional heroism"
	desc = "An extremely rare golden medal awarded only by faction woners. To recieve such a medal is the highest honor and as such, very few exist. This medal is almost never awarded to anybody but commanders."

/*Capes*/

/obj/item/clothing/accessory/cape
	name = "black cloak"
	desc = "A simple black cloak you can attach to your suit for all your edgy needs."
	icon_state = "cloak"
	slot_flags = SLOT_OCLOTHING | SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/cape/blackalt
	name = "black greatcloak"
	desc = "A comfortable black greatcoat, perfect for winter, or simply showing off ones archaic fashion sense."
	icon_state = "cloakalt"

/obj/item/clothing/accessory/cape/fluffy
	name = "fluffy cape"
	desc = "A cloak of old money, comfy, furred, and decadent to all hell, for those who believe your worth as a man is the worth that you bring."
	icon_state = "erp_cape"

/obj/item/clothing/accessory/cape/outsider
	name = "outcast's cloak"
	desc = "A raggedy cloak made of leather and reclaimed materials, can be worn over one's armor as a sign of pride for their outcast nature."
	icon_state = "outsider"

/obj/item/clothing/accessory/cape/scav
	name = "makeshift cape"
	desc = "A cape haphazardly cut from a large bolt of water resistant fabric, while some may wear it for the style, others would prefer it's use as a quick poncho, if it'll every rain."
	icon_state = "scav_mantle"

/obj/item/clothing/accessory/cape/blackedge
	name = "heavy black cloak"
	desc = "A rough and heavy black cloak for draping over yourself like some kind of cave dwelling royal."
	icon_state = "blackcloak"

/obj/item/clothing/accessory/cape/brown
	name = "heavy brown cloak"
	desc = "A rough and heavy brown cloak, perfectly suited to marching through the cold to the front door of an old friend."
	icon_state = "browncloak"

// Head of Departments
/obj/item/clothing/accessory/job/cape
	name = "premier's cloak"
	icon_state = "capcloak"
	desc = "A green-ish cloak with golden lining."
	slot_flags = SLOT_OCLOTHING | SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/job/cape/fo
	name = "premier guard's cloak"
	icon_state = "focloak"
	desc = "A blue cloak with red epaulette."

/obj/item/clothing/accessory/job/cape/meo
	name = "research overseer's cloak"
	icon_state = "meocloak"
	desc = "A white cloak with black double stripe at edge."

/obj/item/clothing/accessory/job/cape/mbo
	name = "biolab overseer's cloak"
	icon_state = "mbocloak"
	desc = "A neon-cyan cloak with nanoleds on its animated medical cross pattern."

/obj/item/clothing/accessory/job/cape/ihc
	name = "warrant officer's cloak"
	icon_state = "ihccloak"
	desc = "A black cloak with dark-blue lining."

/obj/item/clothing/accessory/job/cape/gm
	name = "executive officer's cloak"
	icon_state = "gmcloak"
	desc = "A brown cloak with yellow lining."

/obj/item/clothing/accessory/job/cape/te
	name = "guild master's cloak"
	icon_state = "cecloak"
	desc = "A brown cloak with blue and orange lining."

/obj/item/clothing/accessory/halfcape
	name = "Blackshield Commanders holo-mantle"
	desc = "A fancy holographic mantle cape made from dark fabric and bearing the rank markings of the Blackshield Commander. Despite skillful repair, the signs of multiple back-facing \
	perforations give no doubt as to who this cloak belongs to."
	icon_state = "half_co"
	slot_flags = SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/halfcape/cbo
	name = "Chief Biolab Officers holo-mantle"
	desc = "A fancy holo-mantle made from light fabric and bearing the rank markings of the Soteria CBO. While sleek and sterile, it sadly lacks \
	protection against man-made horrors beyond our comprehension."
	icon_state = "half_cbo"
	slot_flags = SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/halfcape/cro
	name = "Chief Researcher Overseers holo-mantle"
	desc = "A fancy holo-mantle made from dark fabric and bearing the rank markings of the Soteria CRO. Black and purple, a color scheme and style to match the \
	mad scientist in every Overseer."
	icon_state = "half_cro"
	slot_flags = SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/halfcape/gm
	name = "Guildmasters holo-mantle"
	desc = "A fancy holo-mantle made from dark fabric and bearing the rank markings of the Guildmaster. A snagging hazard sure to cause even the most hardened of safety inspectors\
	to blanch."
	icon_state = "half_gm"
	slot_flags = SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/halfcape/foreman
	name = "Foreman holo-mantle"
	desc = "A fancy holo-mantle made from dark fabric and bearing the rank markings of the Foreman. The question hangs as to whether or not the color is from dyes, \
	or the blood of countless voidwolves."
	icon_state = "half_fm"

/obj/item/clothing/accessory/halfcape/wo
	name = "Warrant Officers holo-mantle"
	desc = "A fancy holo-mantle made from dark fabric and bearing the rank markings of the Warrant Officer. A wonderful ostentateous accessory to suit the inflated ego of many a \
	frontier mall-cop."
	icon_state = "half_wo"

/obj/item/clothing/accessory/halfcape/prime
	name = "Primes holo-mantle"
	desc = "A fancy holo-mantle made from dark fabric and bearing the rank markings of the Prime. Muted browns and golds, a perfectly subdued tone to compliment the \
	usual flare of the church."
	icon_state = "half_nt"

/obj/item/clothing/accessory/halfcape/ceo
	name = "CEOs holo-mantle"
	desc = "A fancy holo-mantle made from light-toned silk and bearing the rank markings of the Prime. Fine alabaster silks and gold trim, despite its seemingly similar\
	 make to similar cloaks, its quality cannot be contested."
	icon_state = "half_ceo"


/obj/item/clothing/accessory/halfcape/premier
	name = "Premiers holo-mantle"
	desc = "A fancy, holo-mantle made from fine silk and bearing the rank markings of the Premier. The classic color scheme, coniferous green and tinsel gold. "
	icon_state = "half_prem"


// Department
/obj/item/clothing/accessory/job/cape/service
	name = "service cloak"
	icon_state = "servicecloak"
	desc = "A purple cloak with nanoleds creating sparkling bubbles."

/obj/item/clothing/accessory/job/cape/guild
	name = "lonestar cloak"
	icon_state = "cargocloak"
	desc = "A light-brown cloak."

/obj/item/clothing/accessory/job/cape/mining
	name = "mining cloak"
	icon_state = "miningcloak"
	desc = "A brown cloak with fancy nanoleds displaying an animation of rock being picked."

/obj/item/clothing/accessory/job/cape/technomancer
	name = "adept cloak"
	icon_state = "engicloak"
	desc = "A yellow cloak with orange lining."

/obj/item/clothing/accessory/job/cape/medical
	name = "medical cloak"
	icon_state = "medcloak"
	desc = "A white cloak with a single dark-cyan stripe at edge."

/obj/item/clothing/accessory/job/cape/science
	name = "science cloak"
	icon_state = "scicloak"
	desc = "A white cloak with a single black stripe at edge."

/obj/item/clothing/accessory/job/cape/church
	name = "black Absolutists greatcloak"
	icon_state = "heavychurchcloakblack"
	desc = "A thick, luxurious cloak with black trim."

/obj/item/clothing/accessory/job/cape/church/alt
	name = "red Absolutists greatcloak"
	icon_state = "heavychurchcloakred"
	desc = "A thick, luxurious cloak with red trim."

/obj/item/clothing/accessory/job/cape/church/small
	name = "black Absolutists cloak"
	icon_state = "churchcloakblack"
	desc = "A sleek, luxurious cloak with black trim."

/obj/item/clothing/accessory/job/cape/church/smallalt
	name = "red Absolutists cloak"
	icon_state = "churchcloakblack"
	desc = "A sleek, luxurious cloak with red trim."

/obj/item/clothing/accessory/job/cape/ironhammer
	name = "security cloak"
	icon_state = "seccloak"
	desc = "A blue, navy cloak."

/obj/item/clothing/accessory/job/cape/blackshield
	name = "grey Blackshield cloak"
	desc = "A simple, durable cloak for protecting you in any weather conditions! This one comes in a brooding grey."
	icon_state = "blackshieldcloak"

/obj/item/clothing/accessory/job/cape/blackshield/green
	name = "green Blackshield cloak"
	desc = "A simple, durable cloak for protecting you in any weather conditions! This one comes in a fetching green."
	icon_state = "blackshieldcloak_green"

/obj/item/clothing/accessory/job/cape/blackshield/tan
	name = "tan Blackshield cloak"
	desc = "A simple, durable cloak for protecting you in any weather conditions! This one comes in a light tan."
	icon_state = "blackshieldcloak_tan"

/obj/item/clothing/accessory/job/cape/blackshield/camo
	name = "camo Blackshield cloak"
	desc = "A simple, durable cloak for protecting you in any weather conditions! This one comes in a tactical camo pattern."
	icon_state = "blackshieldcloak_camo"

/obj/item/clothing/accessory/cape/sergeant_cape
	name = "Sergeants mantle"
	desc = "A shoulder-mantlee made from black and silver fabric, denoting the position of Sergeant. Allows for identification at a glance."
	icon_state = "half_sarg"
	slot_flags = SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/cape/blackshield/corpsmans_cape
	name = "Corpsman mantle"
	desc = "A half-cape made from blue and black fabric denoting that they are a corpsman, to be easily seen in the jungle."
	icon_state = "half_corp"
	slot_flags = SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/cape/trooper_cape
	name = "Troopers mantle"
	desc = "A half-cape made from blue and white fabric denoting the rank of Trooper. Allows for identification at a glance"
	icon_state = "half_troop"
	slot_flags = SLOT_ACCESSORY_BUFFER


//Kriosan
/obj/item/clothing/accessory/kricape
	name = "holographic capitoleum cape"
	desc = "A electronic cloak with a holographic interface lining it's stiff wiring. This cape is the only one feared by Castellans, not because of any might or power, but because it signifies one status of being from the capitol, and thus, one's ability to back-stab and lie."
	icon_state = "capital_cape"
	slot_flags = SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/kricape/soldier
	name = "soldier-lord trench cape"
	desc = "A faded grey cape for the nobles-of-the-sword from the land of the Midnight Sun - Reichsritters who forsook high officership billets instead to lead infantry. They are a fading footnote of Kriosian aristocracy, brought to extinction numbers during the Battle of Krios by their leadership methods and the irrelevance of height and physique against the application of 6.5mm Creedmoor to the head by Solfed Scout-Snipers. Without anyone young or willing enough to sire enough to replace the dead, the cape has become the signature of exiled Castellans and the formal apparel of a few notable mercenary-men and duelists, and shall mean nothing in the next few generations."
	icon_state = "krieg_cape"

/obj/item/clothing/accessory/kricape/rural
	name = "farmer barons olive cape"
	desc = "A cloak that define's one status as humble, as humble as a feudal land lord can try. This green, copper clad cloak is commonly worn by échevins-lord houses, those who own great swathes of colonial and rural territory. It's in actuality a self-defence mechanism, the knowledge that if they don't conceal their wealth, the vorhut countryvolk and jaeger frontiersmen they rule over will burn their estates and steal from their coffers."
	icon_state = "pelinal_cape"

/obj/item/clothing/accessory/kricape/bleublood
	name = "admirals dress cape"
	desc = "A blue-gold-cape flecked upon with the smell of expensive cologne and spilt wine - signatures of maritime nobility donned upon what is a cape of Kriosian naval colors.  The naval houses pride (and live upon) their contributions in academy-trained officers, and to see someone else in their colors is an active to passive insult varying on the distance from Kriosian space and proximity to common men."
	icon_state = "bleu_cape"

/* Ponchos */

/obj/item/clothing/accessory/tacticalponcho
	name = "brown tactical poncho"
	desc = "A sleek brown poncho. Great for gunfights at high noon or hiding in the underbrush."
	icon_state = "tacpon_brown"
	slot_flags = SLOT_OCLOTHING | SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/tacticalponcho/green
	name = "green tactical poncho"
	desc = "A sleek, green poncho. Tactical and stylish!"
	icon_state = "tacpon_green"

/obj/item/clothing/accessory/tacticalponcho/camo
	name = "camo tactical poncho"
	desc = "A sleek, tactical camo poncho. Great for remaining inconspicuous in even the most densely  wooded combat enviroments"
	icon_state = "tacpon_camo"

/obj/item/clothing/accessory/tacticalponcho/ghillie
	name = "ghillie poncho"
	desc = "A highly tactical partial ghillie suit adjusted for the upper body, it only makes you look a little goofy when not lying down!"
	icon_state = "tacpon_ghillie"

/*Shirts*/
/obj/item/clothing/accessory/hawaiian
	name = "black Hawaiian shirt"
	desc = "A cool Hawaiian pattern shirt in dark black. Beach Goth 2620 is written on the inner tag."
	icon_state = "hawaiiblack"
	slot_flags = SLOT_OCLOTHING | SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/hawaiian/fuschia
	name = "fuschia Hawaiian shirt"
	desc = "A Hawaiian pattern shirt in brilliant fuschia. You'll be saying 'Mahalo' when someone takes it out of your sight."
	icon_state = "hawaiifuchs"

/obj/item/clothing/accessory/hawaiian/jade
	name = "jade Hawaiian shirt"
	desc = "A Hawaiian pattern shirt of jade and silver. The vine pattern is really pleasing to the eyes!"
	icon_state = "hawaiivine"

/obj/item/clothing/accessory/hawaiian/orange
	name = "orange Hawaiian shirt"
	desc = "A Hawaiian pattern shirt in stunning orange and blue. A true masterpiece that straddles the line between tacky and ageless."
	icon_state = "hawaiiorange"

/obj/item/clothing/accessory/hawaiian/motu
	name = "questionable Hawaiian shirt"
	desc = "A Hawaiian pattern shirt in - wait a minute...hawaii shirts don't have skulls, lightning, or beloved cartoon character he-man on them, you've been had!."
	icon_state = "hawaiimotu"

/obj/item/clothing/accessory/hawaiian/vice
	name = "teal Hawaiian shirt"
	desc = "A Hawaiian shirt with palm-tree pattern and a fetching teal shade. The designer tag reads 'Malibu Club Merch' and has an obviously stamped signature from the presumed designer, 'Tony'"
	icon_state = "hawaiivice"

/obj/item/clothing/accessory/hawaiian/verb/toggle_style()
	set name = "Adjust style"
	set category = "Object"
	set src in usr

	if(!isliving(loc))
		return

	var/mob/M = usr
	var/list/options = list()
	options["button"] = ""
	options["unbutton"] = "_open"

	var/choice = input(M,"What kind of style do you want?","Adjust Style") as null|anything in options

	if(src && choice && !M.incapacitated() && Adjacent(M))
		var/base = initial(icon_state)
		base += options[choice]
		icon_state = base
		item_state = base
		item_state_slots = null
		to_chat(M, "You [choice] your shirt. Aloha!.")
		update_icon()
		update_wear_icon()
		usr.update_action_buttons()
		return 1

/obj/item/clothing/accessory/bscloak
	name = "Blackshield longcoat"
	desc = "A simple, durable longcoat intended to be worn under armored vests for protection in incliment weather."
	icon_state = "bs_longcoat"
	slot_flags = SLOT_OCLOTHING | SLOT_ACCESSORY_BUFFER

/*Scarves*/

/obj/item/clothing/accessory/scarf/black
	name = "black scarf"
	desc = "A stylish black scarf."
	icon_state = "blackscarf"

/obj/item/clothing/accessory/scarf/christmas
	name = "christmas scarf"
	desc = "A stylish red and green scarf."
	icon_state = "christmasscarf"

/obj/item/clothing/accessory/scarf/darkblue
	name = "dark blue scarf"
	desc = "A stylish dark blue scarf."
	icon_state = "darkbluescarf"

/obj/item/clothing/accessory/scarf/green
	name = "green scarf"
	desc = "A stylish green scarf."
	icon_state = "greenscarf"

/obj/item/clothing/accessory/scarf/lightblue
	name = "light blue scarf"
	desc = "A stylish light blue scarf."
	icon_state = "lightbluescarf"

/obj/item/clothing/accessory/scarf/orange
	name = "orange scarf"
	desc = "A stylish orange scarf."
	icon_state = "orangescarf"

/obj/item/clothing/accessory/scarf/purple
	name = "purple scarf"
	desc = "A stylish purple scarf."
	icon_state = "purplescarf"

/obj/item/clothing/accessory/scarf/red
	name = "red scarf"
	desc = "A stylish red scarf."
	icon_state = "redscarf"

/obj/item/clothing/accessory/scarf/white
	name = "white scarf"
	desc = "A stylish white scarf."
	icon_state = "whitescarf"

/obj/item/clothing/accessory/scarf/yellow
	name = "yellow scarf"
	desc = "A stylish yellow scarf."
	icon_state = "yellowscarf"

/obj/item/clothing/accessory/scarf/zebra
	name = "zebra scarf"
	desc = "A stylish black and white scarf."
	icon_state = "zebrascarf"

/obj/item/clothing/accessory/scarf/furblack
	name = "black fur scarf"
	desc = "A furred scarf in a black color."
	icon_state = "furscarf_black"
	item_state = "furscarf_black"

/obj/item/clothing/accessory/scarf/furblue
	name = "blue fur scarf"
	desc = "A furred scarf in a blue color."
	icon_state = "furscarf_blue"
	item_state = "furscarf_blue"

/obj/item/clothing/accessory/scarf/furbrown
	name = "brown fur scarf"
	desc = "A furred scarf in a brown color."
	icon_state = "furscarf_brown"
	item_state = "furscarf_brown"

/obj/item/clothing/accessory/scarf/furcinnamon
	name = "cinnamon fur scarf"
	desc = "A furred scarf in a cinnamon color."
	icon_state = "furscarf_cinnamon"
	item_state = "furscarf_cinnamon"

/obj/item/clothing/accessory/scarf/furcream
	name = "cream fur scarf"
	desc = "A furred scarf in a cream color."
	icon_state = "furscarf_cream"
	item_state = "furscarf_cream"

/obj/item/clothing/accessory/scarf/furlbrown
	name = "light brown fur scarf"
	desc = "A furred scarf in a light brown color."
	icon_state = "furscarf_lbrown"
	item_state = "furscarf_lbrown"

/obj/item/clothing/accessory/scarf/furorange
	name = "orange fur scarf"
	desc = "A furred scarf in a orange color."
	icon_state = "furscarf_lasaga"
	item_state = "furscarf_lasaga"

/obj/item/clothing/accessory/scarf/furruddy
	name = "ruddy fur scarf"
	desc = "A furred scarf in a ruddy color."
	icon_state = "furscarf_ruddy"
	item_state = "furscarf_ruddy"

/obj/item/clothing/accessory/scarf/fursilver
	name = "silver fur scarf"
	desc = "A furred scarf in a silver color."
	icon_state = "furscarf_silver"
	item_state = "furscarf_silver"

/obj/item/clothing/accessory/scarf/neckblue
	name = "blue neck scarf"
	desc = "A blue neck scarf."
	icon_state = "blue_scarf"
	item_state = "blue_scarf"
	body_parts_covered = FACE
	item_flags = FLEXIBLEMATERIAL
	w_class = ITEM_SIZE_SMALL
	gas_transfer_coefficient = 0.90
	price_tag = 50

/obj/item/clothing/accessory/scarf/checkered
	name = "checkered neck scarf"
	desc = "A red and white checkered neck scarf."
	icon_state = "redwhite_scarf"
	item_state = "redwhite_scarf"

/obj/item/clothing/accessory/scarf/neckgreen
	name = "green neck scarf"
	desc = "A green neck scarf."
	icon_state = "green_scarf"
	item_state = "green_scarf"

/obj/item/clothing/accessory/scarf/neckred
	name = "red neck scarf"
	desc = "A red neck scarf."
	icon_state = "red_scarf"
	item_state = "red_scarf"

/obj/item/clothing/accessory/scarf/stripedblue
	name = "striped blue scarf"
	desc = "A striped blue scarf."
	icon_state = "stripedbluescarf"
	item_state = "stripedbluescarf"

/obj/item/clothing/accessory/scarf/stripedgreen
	name = "striped green scarf"
	desc = "A striped green scarf."
	icon_state = "stripedgreenscarf"
	item_state = "stripedgreenscarf"

/obj/item/clothing/accessory/scarf/stripedpurple
	name = "striped green scarf"
	desc = "A striped purple scarf."
	icon_state = "stripedpurplescarf"
	item_state = "stripedpurplescarf"

/obj/item/clothing/accessory/scarf
	name = "striped red scarf"
	desc = "A striped red scarf."
	icon_state = "stripedredscarf"
	item_state = "stripedredscarf"

/obj/item/clothing/accessory/ninjascarf /*Omitted from scarf selection because it's more of a costume piece.*/
	name = "ninja scarf"
	desc = "A stealthy, ominous scarf."
	icon_state = "ninja_scarf"
	item_state = "ninja_scarf"
	siemens_coefficient = 0

/*One-Off Stuff*/

/obj/item/clothing/accessory/dropstraps
	name = "drop straps"
	desc = "White suspenders worn over the shoulders."
	icon_state = "flops"
	item_state = "flops"

/obj/item/clothing/accessory/legbrace
	name = "leg brace"
	desc = "A lightweight polymer frame designed to hold legs upright comfortably."
	icon_state = "legbrace"
	item_state = "legbrace"

/obj/item/clothing/accessory/neckbrace
	name = "neck brace"
	desc = "A lightweight polymer frame designed to hold a neck upright comfortably."
	icon_state = "neckbrace"
	item_state = "neckbrace"


/* Kneepads */

/obj/item/clothing/accessory/kneepads
	name = "cheap kneepads"
	desc = "A set of cheap, dingy old kneepads. Great for a round or two of hand-egg, but probably won't offer any real protection in a combat situation."
	icon_state = "kneepad_cheap"
	item_state = "kneepad_cheap"

/obj/item/clothing/accessory/kneepads/basic
	name = "basic kneepads"
	desc = "A set of decent kneepads. Good for construction work or other mild to heavy duty work! Probably won't offer any real protection in a combat situation."
	icon_state = "kneepad_basic"
	item_state = "kneepad_basic"

/obj/item/clothing/accessory/kneepads/expensive
	name = "fancy kneepads"
	desc = "A set of advanced leg-guards. Perfect for the that chic mercenary look, but less useful for true combat."
	icon_state = "kneepad_expensive"
	item_state = "kneepad_expensive"


/*Ranks*/

/obj/item/clothing/accessory/ranks/blank
	name = "shoulderboards (blank)"
	desc = "Blank red shoulderboards denoting a Blackshield cadet, or, rarely, an emergency volunteer or an off-duty Blackshield Trooper given provisional duty in an emergency."
	icon_state = "blank_tabs"
	item_state = "blank_tabs"

/obj/item/clothing/accessory/ranks/trooper
	name = "shoulderboards (trooper)"
	desc = "Red and silver shoulderboards denoting a Blackshield soldier with the rank of Trooper."
	icon_state = "trooper_tabs"
	item_state = "trooper_tabs"

/obj/item/clothing/accessory/ranks/corpsman
	name = "shoulderboards (corpsman)"
	desc = "Red and silver shoulderboards denoting a Blackshield soldier with the rank of Corpsman."
	icon_state = "corps_tabs"
	item_state = "corps_tabs"

/obj/item/clothing/accessory/ranks/sergeant
	name = "shoulderboards (sergeant)"
	desc = "Red and silver shoulderboards denoting a Blackshield soldier with the rank of Sergeant."
	icon_state = "sergeant_tabs"
	item_state = "sergeant_tabs"

/obj/item/clothing/accessory/ranks/sergeantmajor
	name = "shoulderboards (sergeant major)"
	desc = "Red and silver shoulderboards denoting a Blackshield soldier with the rank of Sergeant Major."
	icon_state = "sergeantm_tabs"
	item_state = "sergeantm_tabs"

/obj/item/clothing/accessory/ranks/commander
	name = "shoulderboards (commander)"
	desc = "Red and gold shoulderboards denoting a Blackshield soldier with the rank of Commander."
	icon_state = "commander_tabs"
	item_state = "commander_tabs"

/obj/item/clothing/accessory/ranks/major
	name = "shoulderboards (major)"
	desc = "Red and gold shoulderboards denoting a Blackshield soldier with the rank of Major."
	icon_state = "major_tabs"
	item_state = "major_tabs"

/obj/item/clothing/accessory/ranks/brigadier
	name = "shoulderboards (brigadier)"
	desc = "Red, gold, and silver shoulderboards denoting the Brigadier."
	icon_state = "brigadier_tabs"
	item_state = "brigadier_tabs"

/obj/item/clothing/accessory/patches/blackshield
	name = "blackshield patch"
	desc = "A black, blue, and silver patch made to represent the Blackshield regiment. For use on uniforms when active, or other clothing in other positions."
	icon_state = "blackshieldpatch"
	item_state = "blackshieldpatch"

/obj/item/clothing/accessory/patches/blackshield_blank
	name = "blackshield blank patch"
	desc = "A black, blue, and silver patch made to represent the Blackshield regiment. For use on uniforms when active, or other clothing in other positions."
	icon_state = "bs_blank"
	item_state = "bs_blank"

/obj/item/clothing/accessory/patches/blackshield_volunteer
	name = "blackshield volunteer patch"
	desc = "A black, blue, and silver patch made to represent the Blackshield regiment. For use on uniforms when active, or other clothing in other positions."
	icon_state = "bs_volunteer"
	item_state = "bs_volunteer"

/obj/item/clothing/accessory/patches/blackshield_trooper
	name = "blackshield trooper patch"
	desc = "A black, blue, and silver patch made to represent the Blackshield regiment. For use on uniforms when active, or other clothing in other positions."
	icon_state = "bs_trooper"
	item_state = "bs_trooper"

/obj/item/clothing/accessory/patches/blackshield_corpsman
	name = "blackshield corpsman patch"
	desc = "A black, blue, and silver patch made to represent the Blackshield regiment. For use on uniforms when active, or other clothing in other positions."
	icon_state = "bs_corpsman"
	item_state = "bs_corpsman"

/obj/item/clothing/accessory/patches/blackshield_sergeant
	name = "blackshield sergeant patch"
	desc = "A black, blue, and silver patch made to represent the Blackshield regiment. For use on uniforms when active, or other clothing in other positions."
	icon_state = "bs_sergeant"
	item_state = "bs_sergeant"

/obj/item/clothing/accessory/patches/blackshield_sergeantmajor
	name = "blackshield sergeant major patch"
	desc = "A black, blue, and silver patch made to represent the Blackshield regiment. For use on uniforms when active, or other clothing in other positions."
	icon_state = "bs_sergeantm"
	item_state = "bs_sergeantm"

/obj/item/clothing/accessory/patches/blackshield_commander
	name = "blackshield commander patch"
	desc = "A black, blue, and silver patch made to represent the Blackshield regiment. For use on uniforms when active, or other clothing in other positions."
	icon_state = "bs_commander"
	item_state = "bs_commander"

/obj/item/clothing/accessory/patches/blackshield_major
	name = "blackshield major patch"
	desc = "A black, blue, and silver patch made to represent the Blackshield regiment. For use on uniforms when active, or other clothing in other positions."
	icon_state = "bs_major"
	item_state = "bs_major"

/obj/item/clothing/accessory/patches/blackshield_brigadier
	name = "blackshield brigadier patch"
	desc = "A black, blue, and silver patch made to represent the Blackshield regiment. For use on uniforms when active, or other clothing in other positions."
	icon_state = "bs_brigadier"
	item_state = "bs_brigadier"

/* Tacticool Shirts / UBACs */

/obj/item/clothing/accessory/tacticool
	name = "black UBAC shirt"
	desc = "A tactical shirt meant to be worn under armor to protect from unpleasant chaffing. Original solfed design in black."
	icon_state = "ubacblack"
	item_state = "ubacblack"
	slot_flags = SLOT_OCLOTHING | SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/tacticool/navy
	name = "navy blue UBAC shirt"
	desc = "A tactical shirt meant to be worn under armor to protect from unpleasant chaffing. Original solfed design in navy blue."
	icon_state = "ubacblue"
	item_state = "ubacblue"
	slot_flags = SLOT_OCLOTHING | SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/tacticool/tan
	name = "tan UBAC shirt"
	desc = "A tactical shirt meant to be worn under armor to protect from unpleasant chaffing. Original solfed design in tan."
	icon_state = "ubactan"
	item_state = "ubactan"
	slot_flags = SLOT_OCLOTHING | SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/tacticool/green
	name = "green UBAC shirt"
	desc = "A tactical shirt meant to be worn under armor to protect from unpleasant chaffing. Original solfed design in green."
	icon_state = "ubacgreen"
	item_state = "ubacgreen"
	slot_flags = SLOT_OCLOTHING | SLOT_ACCESSORY_BUFFER

/* Necklaces and ....chokers (I blame Moon) */

/obj/item/clothing/accessory/necklace
	name = "metal necklace"
	desc = "A shiny steel chain with a vague metallic object dangling off it."
	icon_state = "tronket"
	item_state = "tronket"
	slot_flags = SLOT_MASK | SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/necklace/dogtags
	name = "dog tags"
	desc = "A pair of engraved metal identification tags."
	icon_state = "tags"
	item_state = "tags"

/obj/item/clothing/accessory/necklace/fractalrosary
	name = "Fractal Rosary"
	desc = "This is an insignia given out by the Church of Absolute to people who consider themself to be a Fractal: \
			An individual who believes and follows the Church but has not yet or cannot be inducted to full membership."
	icon_state = "fractal_rosary"
	item_state = "fractal_rosary"

/obj/item/clothing/accessory/choker
	name = "blue choker"
	desc = "A small blue band tied around your neck. You probably don't want to be wearing this if you want to be taken seriously."
	icon_state = "choker"
	overlay_state = "choker"
	slot_flags = SLOT_MASK | SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/choker/red
	name = "red choker"
	desc = "A small red band tied around your neck. You probably don't want to be wearing this if you want to be taken seriously."
	icon_state = "choker_red"
	overlay_state = "choker_red"

/obj/item/clothing/accessory/choker/goth
	name = "gothic choker"
	desc = "A small black band tied around your neck. Makes you look like you either worship satan or just hate your life."
	icon_state = "choker_goth"
	overlay_state = "choker_goth"

/obj/item/clothing/accessory/choker/gold_bell
	name = "Leather Collar (Gold Bell)"
	desc = "A band of supple leather with a locked clasp. A golden cow bell has been attached to reflect a more \"agricultural\" lifestyle."
	icon_state = "collar_gold_bell"
	overlay_state = "collar_gold"

/obj/item/clothing/accessory/choker/silver_bell
	name = "Leather Collar (Silver Bell)"
	desc = "A band of supple leather with a locked clasp. A silver cow bell has been attached to reflect a more \"agricultural\" lifestyle."
	icon_state = "collar_silver_bell"
	overlay_state = "collar_silver"

/obj/item/clothing/accessory/choker/gold_bell_small
	name = "Leather Collar (Small Gold Bell)"
	desc = "A band of supple leather with a locked clasp. A golden sleigh bell has been attached to publically announce the wearer's \"holiday spirit.\""
	icon_state = "collar_gold_bell_small"
	overlay_state = "collar_gold"

/obj/item/clothing/accessory/choker/silver_bell_small
	name = "Leather Collar (Small Silver Bell)"
	desc = "A band of supple leather with a locked clasp. A silver sleigh bell has been attached to publically announce the wearer's \"holiday spirit.\""
	icon_state = "collar_silver_bell_small"
	overlay_state = "collar_silver"

/obj/item/clothing/accessory/choker/gold_tag
	name = "Leather Collar (Gold Tag)"
	desc = "A band of supple leather with a locked clasp. A gold-plated dogtag has been attached to show solidarity with our strong, proud, Blackshield militia."
	icon_state = "collar_gold_tag"
	overlay_state = "collar_gold"

/obj/item/clothing/accessory/choker/silver_tag
	name = "Leather Collar (Silver Tag)"
	desc = "A band of supple leather with a locked clasp. A silver-plated dogtag has been attached to show solidarity with our strong, proud, Blackshield militia."
	icon_state = "collar_silver_tag"
	overlay_state = "collar_silver"

/obj/item/clothing/accessory/choker/gold_bell_goth
	name = "Gothic Collar (Gold Bell)"
	desc = "A black band of studded leather with a locked clasp. A golden cowbell has been attached to chime the song of herbivorous rebellion."
	icon_state = "collar_gold_bell_goth"
	overlay_state = "collar_gold_goth"

/obj/item/clothing/accessory/choker/silver_bell_goth
	name = "Gothic Collar (Silver Bell)"
	desc = "A black band of studded leather with a locked clasp. A silver cowbell has been attached to chime the song of herbivorous rebellion."
	icon_state = "collar_silver_bell_goth"
	overlay_state = "collar_silver_goth"

/obj/item/clothing/accessory/choker/gold_bell_small_goth
	name = "Gothic Collar (Small Gold Bell)"
	desc = "A black band of studded leather with a locked clasp. A golden jingle bell has been attached to announce that a true sleigher has arrived."
	icon_state = "collar_gold_bell_small_goth"
	overlay_state = "collar_gold_goth"

/obj/item/clothing/accessory/choker/silver_bell_small_goth
	name = "Gothic Collar (Small Silver Bell)"
	desc = "A black band of studded leather with a locked clasp. A silver jingle bell has been attached to announce that a true sleigher has arrived."
	icon_state = "collar_silver_bell_small_goth"
	overlay_state = "collar_silver_goth"

/obj/item/clothing/accessory/choker/gold_tag_goth
	name = "Gothic Collar (Gold Tag)"
	desc = "A black band of studded leather with a locked clasp. A golden dogtag has been attached- making it suitable for Kriosans, Naramad and other kinds of dog."
	icon_state = "collar_gold_tag_goth"
	overlay_state = "collar_gold_goth"

/obj/item/clothing/accessory/choker/silver_tag_goth
	name = "Gothic Collar (Silver Tag)"
	desc = "A black band of studded leather with a locked clasp. A silver dogtag has been attached- making it suitable for Kriosans, Naramad and other kinds of dog."
	icon_state = "collar_silver_tag_goth"
	overlay_state = "collar_silver_goth"

/* Bracelets and watches */

/obj/item/clothing/accessory/bracelet
	name = "bracelet"
	desc = "A simple red band wrapped around your wrist. Snazzy."
	icon_state = "bracelet"
	item_state = "bracelet"
	slot_flags = SLOT_GLOVES | SLOT_ACCESSORY_BUFFER

/obj/item/clothing/accessory/bracelet/watch
	name = "fancy watch"
	desc = "An expensive watch with a red band wrapped around your wrist. Snazzy."
	icon_state = "wristwatch_fancy"
	item_state = "wristwatch_fancy"

/obj/item/clothing/accessory/bracelet/watch
	name = "fancy watch"
	desc = "An expensive watch with a red band wrapped around your wrist. Snazzy."
	icon_state = "wristwatch_fancy"
	item_state = "wristwatch_fancy"

/obj/item/clothing/accessory/bracelet/watch/leather
	name = "fancy leather watch"
	desc = "An expensive watch with a leather brown band wrapped around your wrist. Snazzy."
	icon_state = "wristwatch_leather"
	item_state = "wristwatch_leather"

/obj/item/clothing/accessory/bracelet/watch/black
	name = "fancy black watch"
	desc = "An expensive watch with a black band wrapped around your wrist. Snazzy."
	icon_state = "wristwatch_black"
	item_state = "wristwatch_black"
