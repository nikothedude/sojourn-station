// projectile/Test has been proven to be inaccurate and doesn't use the logic behind firing a real projectile.
// impacttest uses the exact same logic, and thus, is perfectly accurate. It operates on the basis that whatever we hit will end the
// flight of the projectile, thus, showing if we can hit a target or not.

/obj/item/projectile/test/impacttest
	hitscan = TRUE
	var/list/fake_damage_types = null

/obj/item/projectile/test/impacttest/launch(atom/target, angle_offset, x_offset, y_offset)

	var/turf/curloc = get_turf(src)
	var/turf/targloc = get_turf(target)

	if (!istype(targloc) || !istype(curloc))
		return TRUE

	if(targloc == curloc) //Shooting something in the same turf
		on_impact(target)
		qdel(src)
		return FALSE

	original = target

	setup_trajectory(curloc, targloc, x_offset, y_offset, angle_offset) //plot the initial trajectory
	Process()

/obj/item/projectile/test/impacttest/Process()
	spawn while(src && src.loc)
		if(kill_count-- < 1)
			on_impact(src.loc) //for any final impact behaviours
			qdel(src)
			return
		if((!( current ) || loc == current))
			current = locate(min(max(x + xo, 1), world.maxx), min(max(y + yo, 1), world.maxy), z)
		if((x == 1 || x == world.maxx || y == 1 || y == world.maxy))
			qdel(src)
			return

		trajectory.increment()	// increment the current location
		location = trajectory.return_location(location)		// update the locally stored location data

		if(!location)
			qdel(src)	// if it's left the world... kill it
			return

		before_move()
		Move(location.return_turf())
		pixel_x = location.pixel_x
		pixel_y = location.pixel_y

		if(!bumped && !isturf(original))
			if(loc == get_turf(original))
				if(Bump(original))
					return

/obj/item/projectile/test/impacttest/on_impact(atom/A)

	SEND_SIGNAL(src, COMSIG_TRACE_IMPACT, src, A)

/obj/item/projectile/test/impacttest/Bump(atom/A, forced)

	if(A == src)
		return FALSE
	if(A == firer)
		loc = A.loc
		return FALSE //go fuck yourself in another place pls
	if (A.type == /mob/observer)
		return FALSE

	if(istype(A, /obj/item/projectile))
		return FALSE

	var/passthrough = FALSE

	passthrough = (A.CanPass(src, get_turf(A)))

	if(!passthrough)
		//stop flying
		on_impact(A)

		qdel(src)

	else
		return FALSE

//return 1 if the projectile should be allowed to pass through after all, 0 if not.
/obj/item/projectile/test/impacttest/check_penetrate(atom/A)
	if(!A || !A.density)
		return TRUE //if whatever it was got destroyed when we hit it, then I guess we can just keep going

	if(istype(A, /obj/mecha))
		return TRUE //mecha have their own penetration handling
	var/damage = damage_types[BRUTE]
	if(ismob(A))
		if(!mob_passthrough_check)
			return 0
		if(iscarbon(A))
			damage *= 0.7
		return 1

	var/chance = 0
	if(istype(A, /turf/simulated/wall))
		var/turf/simulated/wall/W = A
		chance = round(damage/W.material.integrity*180)
	else if(istype(A, /obj/machinery/door))
		var/obj/machinery/door/D = A
		chance = round(damage/D.maxHealth*180)
		if(D.glass) chance *= 2
	else if(istype(A, /obj/structure/girder))
		chance = 100
	else if(istype(A, /obj/machinery) || istype(A, /obj/structure))
		chance = damage

	if(prob(chance))
		if(A.opacity)
			//display a message so that people on the other side aren't so confused
			A.visible_message(SPAN_WARNING("\The [src] pierces through \the [A]!"))
		return 1

	return 0

/proc/check_trajectory_raytrace(var/atom/movable/target,
								var/atom/movable/firer,
								pass_flags=PASSTABLE|PASSGLASS|PASSGRILLE,
								flags=null,
								penetration = 0,
								var/list/damage_types,
								var/signal_handler = proc/handle_trace_impact)

	if(!istype(target) || !istype(firer))
		return FALSE

	var/obj/item/projectile/test/impacttest/trace = new /obj/item/projectile/test/impacttest/(get_turf(firer)) //Making the test....
	trace.pass_flags = pass_flags
	trace.flags = flags
	trace.penetrating = penetration
	trace.fake_damage_types = damage_types

	firer.RegisterSignal(trace, COMSIG_TRACE_IMPACT, signal_handler)

/proc/handle_trace_impact(var/obj/item/projectile/test/impacttest/trace, var/atom/impact_atom)
	SIGNAL_HANDLER

	return FALSE
