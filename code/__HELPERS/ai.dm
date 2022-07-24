///returns if something can be consumed, drink or food
/proc/IsEdible(obj/item/thing)
	if(!istype(thing))
		return FALSE
	if(istype(thing, /obj/item/reagent_containers/food)) //placeholder til i make it a ocomponent
		return TRUE
	if(istype(thing, /obj/item/reagent_containers/food/drinks/drinkingglass))
		var/obj/item/reagent_containers/food/drinks/drinkingglass/glass = thing
		if(glass.reagents.total_volume) // The glass has something in it, time to drink the mystery liquid!
			return TRUE
	return FALSE
