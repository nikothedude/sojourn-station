
/obj/item/device/encryptionkey/
	name = "standard encryption key"
	desc = "An encryption key for a radio headset. Contains cypherkeys."
	icon = 'icons/obj/radio.dmi'
	icon_state = "cypherkey"
	item_state = ""
	w_class = ITEM_SIZE_TINY
	slot_flags = SLOT_EARS
	var/translate_binary = 0
	var/translate_hive = 0
	var/syndie = 0
	var/list/channels = list()
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 1)

/obj/item/device/encryptionkey/attackby(obj/item/W as obj, mob/user as mob)

/obj/item/device/encryptionkey/syndicate
	icon_state = "cypherkey"
	channels = list("Mercenary" = 1)
	origin_tech = list(TECH_ILLEGAL = 3)
	syndie = 1//Signifies that it de-crypts Syndicate transmissions

/obj/item/device/encryptionkey/binary
	icon_state = "cypherkey"
	translate_binary = 1
	origin_tech = list(TECH_ILLEGAL = 3)
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2, MATERIAL_SILVER = 2)

/obj/item/device/encryptionkey/headset_bs
	name = "blackshield radio encryption key"
	icon_state = "sec_cypherkey"
	channels = list("Blackshield" = 1)// "Marshal" = 1 removed do to blackshield being marshals illegal

/obj/item/device/encryptionkey/headset_mar
	name = "security radio encryption key"
	icon_state = "sec_cypherkey"
	channels = list("Marshal" = 1, "Blackshield" = 1)

/obj/item/device/encryptionkey/headset_eng
	name = "guild radio encryption key"
	icon_state = "eng_cypherkey"
	channels = list("Engineering" = 1)

/obj/item/device/encryptionkey/headset_rob
	name = "sotiera robotics radio encryption key"
	icon_state = "rob_cypherkey"
	channels = list("Engineering" = 1, "Science" = 1)

/obj/item/device/encryptionkey/headset_med
	name = "soteria medical radio encryption key"
	icon_state = "med_cypherkey"
	channels = list("Medical" = 1)

/obj/item/device/encryptionkey/headset_church
	name = "church radio encryption key"
	icon_state = "nt_cypherkey"
	channels = list("Church" = 1)

/obj/item/device/encryptionkey/headset_sci
	name = "soteria science radio encryption key"
	icon_state = "sci_cypherkey"
	channels = list("Science" = 1)

/obj/item/device/encryptionkey/headset_moebius
	name = "soteria laboratories encryption key"
	icon_state = "sci_cypherkey"
	channels = list("Science" = 1, "Medical" = 1)

/obj/item/device/encryptionkey/headset_com
	name = "council command radio encryption key"
	icon_state = "com_cypherkey"
	channels = list("Command" = 1)

/obj/item/device/encryptionkey/heads/captain
	name = "premier's encryption key"
	icon_state = "cap_cypherkey"
	channels = list("Command" = 1, "Prospector" = 1,  "Engineering" = 0, "Church" = 0, "Science" = 0, "Medical" = 0, "Supply" = 0, "Service" = 0, "Blackshield" = 1, "Marshal" = 1, "Plasmatag B" = 0, "Plasmatag R" = 0, "Plasmatag G" = 0, "Plasmatag Y" = 0)

/obj/item/device/encryptionkey/heads/ai_integrated
	name = "ai integrated encryption key"
	desc = "Integrated encryption key"
	icon_state = "cap_cypherkey"
	channels = list("Command" = 1, "Prospector" = 1,  "Engineering" = 1, "Church" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1, "AI Private" = 1, "Blackshield" = 1, "Marshal" = 1, "Plasmatag B" = 1, "Plasmatag R" = 1, "Plasmatag G" = 1, "Plasmatag Y" = 1)

/obj/item/device/encryptionkey/heads/rd
	name = "research overseer's encryption key"
	icon_state = "rd_cypherkey"
	channels = list("Science" = 1, "Medical" = 1, "Command" = 1)
	translate_binary = 1

/obj/item/device/encryptionkey/heads/moebius
	name = "soteria command encryption key"
	icon_state = "rd_cypherkey"
	channels = list("Science" = 1, "Medical" = 1, "Command" = 1)

/obj/item/device/encryptionkey/heads/hos
	name = "security commander's encryption key"
	icon_state = "hos_cypherkey"
	channels = list("Command" = 1, "Blackshield" = 1, "Marshal" = 1)

/obj/item/device/encryptionkey/heads/ce
	name = "guild master's encryption key"
	icon_state = "ce_cypherkey"
	channels = list("Engineering" = 1, "Command" = 1)

/obj/item/device/encryptionkey/heads/cmo
	name = "biolab overseer's encryption key"
	icon_state = "cmo_cypherkey"
	channels = list("Medical" = 1, "Command" = 1)

/obj/item/device/encryptionkey/heads/hop
	name = "steward's encryption key"
	icon_state = "hop_cypherkey"
	channels = list("Command" = 1, "Prospector" = 1,  "Engineering" = 0, "Church" = 0, "Science" = 0, "Medical" = 0, "Supply" = 0, "Service" = 0, "Blackshield" = 1, "Marshal" = 1, "Plasmatag B" = 0, "Plasmatag R" = 0, "Plasmatag G" = 0, "Plasmatag Y" = 0)

/obj/item/device/encryptionkey/heads/merchant
	name = "lonestar executive radio encryption key"
	icon_state = "qm_cypherkey"
	channels = list("Supply" = 1, "Prospector" = 1, "Command" = 1, "Service" = 1)

/obj/item/device/encryptionkey/heads/preacher
	name = "prime's radio encryption key"
	icon_state = "preach_cypherkey"
	channels = list("Church" = 1, "Command" = 1)

/obj/item/device/encryptionkey/headset_cargo
	name = "lonestar radio encryption key"
	icon_state = "cargo_cypherkey"
	channels = list("Supply" = 1, "Service" = 1)

/obj/item/device/encryptionkey/headset_service
	name = "lonestar service radio encryption key"
	icon_state = "srv_cypherkey"
	channels = list("Service" = 1)

/obj/item/device/encryptionkey/headset_pro
	name = "prospector radio encryption key"
	icon_state = "srv_cypherkey"
	channels = list("Prospector" = 1, "Supply" = 1)

/obj/item/device/encryptionkey/heads/foreman
	name = "prospector radio encryption key"
	icon_state = "qm_cypherkey"
	channels = list("Prospector" = 1, "Supply" = 1, "Command" = 1)

/obj/item/device/encryptionkey/entertainment
	name = "entertainment radio key"
	channels = list("Supply" = 1)

/obj/item/device/encryptionkey/headset_blueteam
	name = "entertainment radio key"
	channels = list("Plasmatag B" = 1)

/obj/item/device/encryptionkey/headset_redteam
	name = "entertainment radio key"
	channels = list("Plasmatag R" = 1)

/obj/item/device/encryptionkey/headset_yellowteam
	name = "entertainment radio key"
	channels = list("Plasmatag Y" = 1)

/obj/item/device/encryptionkey/headset_greenteam
	name = "entertainment radio key"
	channels = list("Plasmatag G" = 1)
