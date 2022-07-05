//Caliber Defines
#define CAL_PISTOL /obj/item/projectile/bullet/pistol_35
#define CAL_MAGNUM /obj/item/projectile/bullet/magnum_40
#define CAL_LRIFLE /obj/item/projectile/bullet/light_rifle_257
#define CAL_RIFLE /obj/item/projectile/bullet/rifle_75
#define CAL_HRIFLE /obj/item/projectile/bullet/heavy_rifle_408
#define CAL_1024 /obj/item/projectile/bullet/c10x24
#define CAL_ROD /obj/item/projectile/bullet/reusable/rod_bolt
#define CAL_ANTIM /obj/item/projectile/bullet/antim
#define CAL_BALL /obj/item/projectile/bullet/ball
#define CAL_SHOTGUN /obj/item/projectile/bullet/shotgun
#define CAL_50	/obj/item/projectile/bullet/kurtz_50
#define CAL_70 /obj/item/projectile/bullet/gyro
#define CAL_CAP /obj/item/projectile/bullet/cap
#define CAL_ROCKET /obj/item/projectile/bullet/rocket
#define CAL_DART /obj/item/projectile/bullet/chemdart
#define CAL_SCI /obj/item/projectile/beam/weak
#define CAL_GRENADE /obj/item/projectile/bullet/batonround
#define CAL_FLARE /obj/item/projectile/bullet/flare/green
#define CAL_CROSSBOW /obj/item/projectile/bullet/crossbow_bolt
#define CAL_ARROW /obj/item/projectile/bullet/reusable/arrow

//Gun loading types
#define SINGLE_CASING 	1	//The gun only accepts ammo_casings. ammo_magazines should never have this as their mag_type.
#define SPEEDLOADER 	2	//Transfers casings from the mag to the gun when used.
#define MAGAZINE 		4	//The magazine item itself goes inside the gun

#define MAG_WELL_GENERIC	0	//Guns without special magwells
#define MAG_WELL_L_PISTOL	1	//Pistols
#define MAG_WELL_PISTOL		2
#define MAG_WELL_H_PISTOL	4	//High cap Pistols
#define MAG_WELL_SMG		8	//smgs
#define MAG_WELL_RIFLE		16	//7.62mm mags / SBAW (essentially shotgun rifle magazine)
#define MAG_WELL_STANMAG	32	//6.5mm standard
#define MAG_WELL_BOX		64	//Lmgs with box mags
#define MAG_WELL_PAN		128	//Lmgs with pan mags
#define MAG_WELL_DART       256 //Dartgun mag
#define MAG_WELL_HRIFLE		512 //8.6mm heavy rifle mags
#define MAG_WELL_DRUM		1024 //Drum-fed i.e. shotguns
#define MAG_WELL_PULSE		2048 //Mary sue ammo for the pulse rifle
#define MAG_WELL_LSRIFLE	4096 //Mary sue ammo for the laser AK
#define MAG_WELL_LINKED_BOX	8192 //Linked ammo boxes, for lmgs

#define SLOT_BARREL "barrel"
#define SLOT_GRIP "grip"
#define SLOT_TRIGGER "trigger"
#define SLOT_MUZZLE "muzzle"
#define SLOT_SCOPE "scope"
#define SLOT_UNDERBARREL "underbarrel"
#define SLOT_MECHANICS "mechanics"
#define SLOT_MAGWELL "magwell"
