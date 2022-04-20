/* Closets for specific jobs
 * Contains:
 *		Bartender
 *		Janitor
 *		Lawyer
 *		Acolyte
 */

/*
 * Bartender
 */
/obj/structure/closet/gmcloset
	name = "formal closet"
	desc = "It's a storage unit for formal clothing."
	icon_door = "black"

/obj/structure/closet/gmcloset/populate_contents()
	new /obj/item/clothing/head/tophat(src)
	new /obj/item/clothing/head/tophat(src)
	new /obj/item/device/radio/headset/headset_service(src)
	new /obj/item/device/radio/headset/headset_service(src)
	new /obj/item/clothing/head/hairflower
	new /obj/item/clothing/suit/storage/toggle/club(src)
	new /obj/item/clothing/under/rank/bartender(src)
	new /obj/item/clothing/under/rank/bartender(src)
	new /obj/item/clothing/suit/storage/wcoat/black(src)
	new /obj/item/clothing/suit/storage/wcoat/black(src)
	new /obj/item/clothing/shoes/color/black(src)
	new /obj/item/clothing/shoes/color/black(src)
	new /obj/item/clothing/under/rank/bartender/skirt(src)

/*
 * Chef
 */
/obj/structure/closet/chefcloset
	name = "chef's closet"
	desc = "It's a storage unit for foodservice garments."
	icon_door = "black"

/obj/structure/closet/chefcloset/populate_contents()
	new /obj/item/clothing/under/costume/job/waiter(src)
	new /obj/item/clothing/under/costume/job/waiter(src)
	new /obj/item/clothing/under/waiter/skirt(src)
	new /obj/item/device/radio/headset/headset_service(src)
	new /obj/item/device/radio/headset/headset_service(src)
	new /obj/item/storage/box/mousetraps(src)
	new /obj/item/storage/box/mousetraps(src)
	new /obj/item/clothing/under/rank/chef(src)
	new /obj/item/clothing/head/rank/chef(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/shoes/laceup/white(src)
	new /obj/item/clothing/under/helltaker_m(src)
	new /obj/item/clothing/under/helltaker(src)
	new /obj/item/clothing/suit/storage/helltaker_apron(src)

/*
 * Janitor
 */
/obj/structure/closet/jcloset
	name = "janitorial closet" //TODO: additonal tools for janitor only
	desc = "It's a storage unit for janitorial clothes and gear."
	icon_door = "mixed"

/obj/structure/closet/jcloset/populate_contents()
	if(prob(50))
		new /obj/item/storage/backpack/sport/purple(src)
	else
		new /obj/item/storage/backpack/satchel(src)
	new /obj/item/clothing/under/rank/janitor(src)
	new /obj/item/device/radio/headset/headset_service(src)
	new /obj/item/clothing/gloves/thick(src)
	new /obj/item/clothing/head/soft/purple(src)
	new /obj/item/clothing/head/beret/purple(src)
	new /obj/item/device/lighting/toggleable/flashlight(src)
	new /obj/item/caution(src)
	new /obj/item/caution(src)
	new /obj/item/caution(src)
	new /obj/item/caution(src)
	new /obj/item/device/lightreplacer(src)
	new /obj/item/storage/bag/trash(src)
	new /obj/item/clothing/shoes/galoshes(src)
	new /obj/item/mop(src)
	new /obj/item/soap/deluxe(src)
	new /obj/item/storage/pouch/small_generic(src) // Because I feel like poor janitor gets it bad.
	new /obj/item/newspaper_stack(src)
	new /obj/item/holyvacuum(src)
	new /obj/item/clothing/accessory/job/cape/service(src) // Boobles! - Seb

/obj/structure/closet/custodial
	name = "church custodial closet"
	desc = "It's a storage unit for janitorial equipment."
	icon_state = "custodian"

/obj/structure/closet/custodial/populate_contents()
	new /obj/item/storage/belt/utility/neotheology(src)
	new /obj/item/device/lighting/toggleable/flashlight(src)
	new /obj/item/gun/matter/launcher/nt_sprayer(src)
	new /obj/item/caution(src)
	new /obj/item/caution(src)
	new /obj/item/caution(src)
	new /obj/item/caution(src)
	new /obj/item/device/lightreplacer(src)
	new /obj/item/storage/bag/trash(src)
	new /obj/item/mop(src)
	new /obj/item/soap/church(src)
	new /obj/item/storage/pouch/small_generic(src) // Because I feel like poor janitor gets it bad.
	new /obj/item/tool/knife/dagger/nt(src)
	new /obj/item/clothing/suit/armor/vest/custodian(src)
	new /obj/item/clothing/head/helmet/custodian(src)
	new /obj/item/newspaper_stack(src)
	new /obj/item/holyvacuum(src)

/obj/structure/closet/acolyte
	name = "vector closet"
	desc = "A closet for those that work with the machines of god."
	icon_state = "acolyte"

/obj/structure/closet/acolyte/populate_contents()
	if(prob(25))
		new /obj/item/storage/backpack/neotheology(src)
	else if(prob(25))
		new /obj/item/storage/backpack/sport/neotheology(src)
	else
		new /obj/item/storage/backpack/satchel/neotheology(src)
	new /obj/item/clothing/under/rank/acolyte(src)
	new /obj/item/storage/belt/utility/neotheology(src)
	new /obj/item/clothing/mask/gas/germanmask(src)
	new /obj/item/device/radio/headset/church(src)
	new /obj/item/clothing/gloves/thick(src)
	new /obj/item/clothing/suit/armor/vest/acolyte(src)
	new /obj/item/clothing/head/helmet/acolyte(src)
	new /obj/item/clothing/under/rank/church/sport(src)
	new /obj/item/clothing/suit/storage/neotheosports(src)
	new /obj/item/gun/energy/ntpistol(src)
	new /obj/item/cell/small(src)
	new /obj/item/tool/knife/dagger/nt(src)
