/**
 * Lets the turf this atom's *ICON* appears to inhabit
 * it takes into account:
 * Pixel_x/y
 * Matrix x/y
 * NOTE: if your atom has non-standard bounds then this proc
 * will handle it, but:
 * if the bounds are even, then there are an even amount of "middle" turfs, the one to the EAST, NORTH, or BOTH is picked
 * this may seem bad, but you're atleast as close to the center of the atom as possible, better than byond's default loc being all the way off)
 * if the bounds are odd, the true middle turf of the atom is returned
**/
/proc/get_turf_pixel(atom/checked_atom)
	if(!istype(checked_atom))
		return

	//Find checked_atom's matrix so we can use it's X/Y pixel shifts
	var/matrix/atom_matrix = matrix(checked_atom.transform)

	var/pixel_x_offset = checked_atom.pixel_x + atom_matrix.get_x_shift()
	var/pixel_y_offset = checked_atom.pixel_y + atom_matrix.get_y_shift()

	//Irregular objects
	var/icon/checked_atom_icon = icon(checked_atom.icon, checked_atom.icon_state)
	var/checked_atom_icon_height = checked_atom_icon.Height()
	var/checked_atom_icon_width = checked_atom_icon.Width()
	if(checked_atom_icon_height != world.icon_size || checked_atom_icon_width != world.icon_size)
		pixel_x_offset += ((checked_atom_icon_width / world.icon_size) - 1) * (world.icon_size * 0.5)
		pixel_y_offset += ((checked_atom_icon_height / world.icon_size) - 1) * (world.icon_size * 0.5)

	//DY and DX
	var/rough_x = round(round(pixel_x_offset, world.icon_size) / world.icon_size)
	var/rough_y = round(round(pixel_y_offset, world.icon_size) / world.icon_size)

	//Find coordinates
	var/turf/atom_turf = get_turf(checked_atom) //use checked_atom's turfs, as it's coords are the same as checked_atom's AND checked_atom's coords are lost if it is inside another atom
	if(!atom_turf)
		return null
	var/final_x = clamp(atom_turf.x + rough_x, 1, world.maxx)
	var/final_y = clamp(atom_turf.y + rough_y, 1, world.maxy)

	if(final_x || final_y)
		return locate(final_x, final_y, atom_turf.z)
