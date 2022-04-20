/obj/machinery/vending/boozeomat
	name = "Booze-O-Mat"
	desc = "A technological marvel, supposedly able to mix just the mixture you'd like to drink the moment you ask for one."
	icon_state = "boozeomat"	//24(+2) drink entities below, plus the glasses, in case someone wants to edit the number of bottles
	icon_deny = "boozeomat-deny"
	products = list(/obj/item/reagent_containers/food/drinks/bottle/gin = 5,
					/obj/item/reagent_containers/food/drinks/bottle/whiskey = 5,
					/obj/item/reagent_containers/food/drinks/bottle/tequilla = 5,
					/obj/item/reagent_containers/food/drinks/bottle/vodka = 5,
					/obj/item/reagent_containers/food/drinks/bottle/vermouth = 5,
					/obj/item/reagent_containers/food/drinks/bottle/rum = 5,
					/obj/item/reagent_containers/food/drinks/bottle/wine = 5,
					/obj/item/reagent_containers/food/drinks/bottle/cognac = 5,
					/obj/item/reagent_containers/food/drinks/bottle/kahlua = 5,
					/obj/item/reagent_containers/food/drinks/bottle/small/beer = 6,
					/obj/item/reagent_containers/food/drinks/bottle/small/ale = 6,
					/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 4,
					/obj/item/reagent_containers/food/drinks/bottle/tomatojuice = 4,
					/obj/item/reagent_containers/food/drinks/bottle/limejuice = 4,
					/obj/item/reagent_containers/food/drinks/bottle/cream = 4,
					/obj/item/reagent_containers/food/drinks/bottle/pineapplejuice = 4,
					/obj/item/reagent_containers/food/drinks/cans/tonic = 8,
					/obj/item/reagent_containers/food/drinks/bottle/cola = 5,
					/obj/item/reagent_containers/food/drinks/bottle/space_up = 5,
					/obj/item/reagent_containers/food/drinks/bottle/space_mountain_wind = 5,
					/obj/item/reagent_containers/food/drinks/cans/sodawater = 11,
					/obj/item/reagent_containers/food/drinks/flask/barflask = 2,
					/obj/item/reagent_containers/food/drinks/flask/vacuumflask = 2,
					/obj/item/reagent_containers/food/drinks/drinkingglass = 30,
					/obj/item/reagent_containers/food/drinks/ice = 9,
					/obj/item/reagent_containers/food/drinks/bottle/melonliquor = 2,
					/obj/item/reagent_containers/food/drinks/bottle/bluecuracao = 2,
					/obj/item/reagent_containers/food/drinks/bottle/redcandywine = 2,
					/obj/item/reagent_containers/food/drinks/bottle/nanatsunoumi = 2,
					/obj/item/reagent_containers/food/drinks/bottle/absinthe = 2,
					/obj/item/reagent_containers/food/drinks/bottle/grenadine = 5,
					/obj/item/reagent_containers/food/snacks/candy/pistachios_pack = 4
					)
	contraband = list(/obj/item/reagent_containers/food/drinks/tea/green = 10,
						/obj/item/reagent_containers/food/drinks/tea/black = 10,
						/obj/item/reagent_containers/food/drinks/bottle/fernet = 5,
						/obj/item/reagent_containers/food/drinks/bottle/neulandschnapps = 3)
	vend_delay = 15
	idle_power_usage = 211 //refrigerator - believe it or not, this is actually the average power consumption of a refrigerated vending machine according to NRCan.
	product_slogans = "I hope nobody asks me for a bloody cup o' tea...;Alcohol is humanity's friend. Would you abandon a friend?;Quite delighted to serve you!;Is nobody thirsty on this colony?;Care for a cup of coffee? It's Irish.;Whiskey for your sorrows, Beer for your break."
	product_ads = "Drink up!;Booze is good for you!;Alcohol is humanity's best friend.;Quite delighted to serve you!;Care for a nice, cold beer?;Nothing cures you like booze!;Have a sip!;Have a drink!;Have a beer!;Beer is good for you!;Only the finest alcohol!;Best quality booze since 2053!;Award-winning wine!;Maximum alcohol!;Man loves beer.;A toast for progress!"
	auto_price = FALSE

/obj/machinery/vending/coffee
	name = "Hot Coffee"
	desc = "A vending machine which dispenses hot drinks."
	product_slogans = "Care for a cup of hot joe?;Care for a cup of coffee?;How about a pick-me-upper?;Want a nice tea?;I hope you ask me for a bloody cup o' tea...;Only the finest!"
	product_ads = "Have a drink!;Drink up!;It's good for you!;Would you like a hot joe?;I'd kill for some coffee!;The best beans in the galaxy.;Only the finest brew for you.;Mmmm. Nothing like a coffee.;I like coffee, don't you?;Coffee helps you work!;Try some tea.;We hope you like the best!;Try our hot chocolate!"
	icon_state = "coffee"
	icon_vend = "coffee-vend"
	vend_delay = 34
	idle_power_usage = 211 //refrigerator - believe it or not, this is actually the average power consumption of a refrigerated vending machine according to NRCan.
	vend_power_usage = 85000 //85 kJ to heat a 250 mL cup of coffee
	products = list(/obj/item/reagent_containers/food/drinks/coffee = 5,
					/obj/item/reagent_containers/food/drinks/h_chocolate = 5,
					/obj/item/reagent_containers/food/drinks/tea/black = 5,
					/obj/item/reagent_containers/food/drinks/tea/green = 5,
					/obj/item/reagent_containers/food/drinks/dry_ramen/premade = 2,
					/obj/item/reagent_containers/food/condiment/pack/sugar = 10,
					/obj/item/reagent_containers/food/condiment/pack/milk = 10)
	contraband = list(/obj/item/reagent_containers/food/drinks/ice = 5,
					  /obj/item/reagent_containers/food/condiment/pack/hotsauce = 10)
	prices = list(/obj/item/reagent_containers/food/drinks/coffee = 10,
					/obj/item/reagent_containers/food/drinks/tea/black = 12,
					/obj/item/reagent_containers/food/drinks/tea/green = 12,
					/obj/item/reagent_containers/food/drinks/h_chocolate = 15,
					/obj/item/reagent_containers/food/condiment/pack/hotsauce = 3,
					/obj/item/reagent_containers/food/condiment/pack/sugar = 5,
					/obj/item/reagent_containers/food/condiment/pack/milk = 5,
					/obj/item/reagent_containers/food/drinks/dry_ramen/premade = 100)

/obj/machinery/vending/coffee/postvend_effect()
	playsound(loc, 'sound/machines/vending_coffee.ogg', 100, 1)
	return

/obj/machinery/vending/snack
	name = "Getmore Chocolate Corp"
	desc = "A snack machine courtesy of the Getmore Chocolate Corporation."
	product_slogans = "Try our new nougat bar!;Twice the calories for half the price!;You know you want it!;So good, try it!;Why not have a treat?;Better than Kitchen's food!"
	product_ads = "The healthiest!;Award-winning chocolate bars!;Mmm! So good!;Have a snack.;Snacks are good for you!;Have some more Getmore!;Best quality snacks straight from mars.;We love chocolate!;Try our new jerky!;Have a treat!;Crunchy!"
	icon_state = "snack"
	products = list(/obj/item/reagent_containers/food/snacks/candy = 2,
					/obj/item/reagent_containers/food/snacks/openable/gamerchips = 1,
					/obj/item/reagent_containers/food/snacks/openable/chips = 2,
					/obj/item/reagent_containers/food/snacks/candy/pistachios_pack = 1,
					/obj/item/reagent_containers/food/snacks/candy/sunflowerseeds = 1,
					/obj/item/reagent_containers/food/snacks/openable/tastybread = 3,
					/obj/item/reagent_containers/food/drinks/dry_ramen = 1,
					/obj/item/reagent_containers/food/snacks/sosjerky = 2,
					/obj/item/reagent_containers/food/snacks/openable/no_raisin = 2,
					/obj/item/reagent_containers/food/snacks/openable/spacetwinkie = 2,
					/obj/item/reagent_containers/food/snacks/cheesiehonkers = 2,
					/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
					/obj/item/reagent_containers/food/snacks/candy_drop_blue = 2,
					/obj/item/storage/fancy/dogtreats = 2,)
	contraband = list(/obj/item/reagent_containers/food/snacks/openable/syndicake = 6)
	prices = list(/obj/item/reagent_containers/food/snacks/candy = 20,
					/obj/item/reagent_containers/food/drinks/dry_ramen = 25,
					/obj/item/reagent_containers/food/snacks/openable/chips = 20,
					/obj/item/reagent_containers/food/snacks/sosjerky = 25,
					/obj/item/reagent_containers/food/snacks/openable/no_raisin = 20,
					/obj/item/reagent_containers/food/snacks/openable/spacetwinkie = 20,
					/obj/item/reagent_containers/food/snacks/cheesiehonkers = 20,
					/obj/item/reagent_containers/food/snacks/openable/tastybread = 25,
					/obj/item/reagent_containers/food/snacks/openable/syndicake = 30,
					/obj/item/reagent_containers/food/snacks/candy/sunflowerseeds = 60,
					/obj/item/reagent_containers/food/snacks/candy/pistachios_pack = 60,
					/obj/item/reagent_containers/food/snacks/chocolatebar = 75,
					/obj/item/reagent_containers/food/snacks/openable/gamerchips = 80,
					/obj/item/reagent_containers/food/snacks/candy_drop_blue = 90,
					/obj/item/storage/fancy/dogtreats = 125)

/obj/machinery/vending/cola
	name = "Robust Softdrinks"
	desc = "A softdrink vendor provided by Lone Star Solutions, LLC."
	icon_state = "Cola_Machine"
	product_slogans = "Robust Softdrinks: More robust than a toolbox to the head!;Operating heavy machinery? Robust Softdrinks has you covered!;Just to fill your sweet tooth needs!;Don't believe the reports, It doesn't have that much sugar!;Thirsty? Why not have cola!;Get your sugarwater here!;The taste of freedom!"
	product_ads = "Refreshing!;Hope you're thirsty!;Over 1 million drinks sold!;Thirsty? Why not have some cola?;Please, have a drink!;Drink up!;The best drinks in this colony.;Treat yourself to what you deserve!"
	products = list(/obj/item/reagent_containers/food/drinks/cans/cola = 10,
					/obj/item/reagent_containers/food/drinks/cans/space_mountain_wind = 10,
					/obj/item/reagent_containers/food/drinks/cans/dr_gibb = 10,
					/obj/item/reagent_containers/food/drinks/cans/starkist = 10,
					/obj/item/reagent_containers/food/drinks/cans/space_up = 10,
					/obj/item/reagent_containers/food/drinks/cans/iced_tea = 10,
					/obj/item/reagent_containers/food/drinks/cans/grape_juice = 10,
					/obj/item/reagent_containers/food/drinks/cans/waterbottle = 10,)
	contraband = list(/obj/item/reagent_containers/food/drinks/cans/thirteenloko = 5,
						/obj/item/reagent_containers/food/snacks/openable/liquidfood = 6)
	prices = list(/obj/item/reagent_containers/food/drinks/cans/cola = 20,
					/obj/item/reagent_containers/food/drinks/cans/space_mountain_wind = 20,
					/obj/item/reagent_containers/food/drinks/cans/dr_gibb = 20,
					/obj/item/reagent_containers/food/drinks/cans/starkist = 20,
					/obj/item/reagent_containers/food/drinks/cans/waterbottle = 16,
					/obj/item/reagent_containers/food/drinks/cans/space_up = 20,
					/obj/item/reagent_containers/food/drinks/cans/iced_tea = 20,
					/obj/item/reagent_containers/food/drinks/cans/grape_juice = 20,
					/obj/item/reagent_containers/food/drinks/cans/thirteenloko = 25,
					/obj/item/reagent_containers/food/snacks/openable/liquidfood = 30)
	idle_power_usage = 211 //refrigerator - believe it or not, this is actually the average power consumption of a refrigerated vending machine according to NRCan.

/obj/machinery/vending/cola/postvend_effect()
	playsound(loc, 'sound/machines/vending_coffee.ogg', 100, 1)
	return

/obj/machinery/vending/hydronutrients
	name = "NutriMax"
	desc = "A plant nutrients vendor."
	product_slogans = "Aren't you glad you don't have to fertilize the natural way?;Now with 50% less stink!;Plants are people too!;150% of the Effects, 0% of the smell!;We all like plants, don't we?;Remember to Never Underestimate Technology.;Take the spray and ROBUST THOSE PESTS!;Save your plants today!;Your plants deserve only the most Robust chemicals!"
	product_ads = "We like plants!;Don't you want some?;The greenest thumbs ever.;We like big plants.;Soft soil..."
	icon_state = "nutri"
	products = list(/obj/item/reagent_containers/glass/fertilizer/ez = 6,
					/obj/item/reagent_containers/glass/fertilizer/l4z = 4,
					/obj/item/reagent_containers/glass/fertilizer/rh = 4,
					/obj/item/plantspray/pests = 20,
					/obj/item/reagent_containers/syringe = 5,
					/obj/item/storage/bag/produce = 5)
	premium = list(/obj/item/reagent_containers/glass/bottle/ammonia = 10,
					/obj/item/reagent_containers/glass/bottle/diethylamine = 5)
	idle_power_usage = 211 //refrigerator - believe it or not, this is actually the average power consumption of a refrigerated vending machine according to NRCan.
	auto_price = FALSE

/obj/machinery/vending/hydroseeds
	name = "MegaSeed Servitor"
	desc = "When you need seeds fast!"
	product_slogans = "This is where the seeds live, git you some!;Hands down the best seed selection on the colony!;Also certain mushroom varieties available, more for experts! Get certified today!;Seeds? We got you covered.;Remember: Glowshrooms are bad for you.;I'm legally advised to tell you that Nettles are poisonous."
	product_ads = "We like plants!;Grow some crops!;Grow, baby, growww!;Aw h'yeah son!;Just like your ancestors!"
	icon_state = "seeds"
	always_open = TRUE
	can_stock = list(/obj/item/seeds)

	products = list(
					/obj/item/seeds/ambrosiarobusto = 3,
					/obj/item/seeds/bananaseed = 3,
					/obj/item/seeds/berryseed = 3,
					/obj/item/seeds/blueberryseed = 3,
					/obj/item/seeds/carrotseed = 3,
					/obj/item/seeds/chantermycelium = 3,
					/obj/item/seeds/chiliseed = 3,
					/obj/item/seeds/cinnamonseed = 2,
					/obj/item/seeds/cornseed = 3,
					/obj/item/seeds/eggplantseed = 3,
					/obj/item/seeds/potatoseed = 3,
					/obj/item/seeds/soyaseed = 3,
					/obj/item/seeds/sunflowerseed = 3,
					/obj/item/seeds/mintseed = 2,
					/obj/item/seeds/tomatoseed = 3,
					/obj/item/seeds/towermycelium = 3,
					/obj/item/seeds/wheatseed = 3,
					/obj/item/seeds/appleseed = 3,
					/obj/item/seeds/poppyseed = 3,
					/obj/item/seeds/sugarcaneseed = 3,
					/obj/item/seeds/peanutseed = 3,
					/obj/item/seeds/whitebeetseed = 3,
					/obj/item/seeds/watermelonseed = 3,
					/obj/item/seeds/limeseed = 3,
					/obj/item/seeds/lemonseed = 3,
					/obj/item/seeds/orangeseed = 3,
					/obj/item/seeds/strawberryseed = 3,
					/obj/item/seeds/grassseed = 3,
					/obj/item/seeds/cocoapodseed = 3,
					/obj/item/seeds/plumpmycelium = 2,
					/obj/item/seeds/cabbageseed = 3,
					/obj/item/seeds/grapeseed = 3,
					/obj/item/seeds/pumpkinseed = 3,
					/obj/item/seeds/thaadra = 3,
					/obj/item/seeds/cherryseed = 3,
					/obj/item/seeds/plastiseed = 3,
					/obj/item/seeds/riceseed = 3,
					/obj/item/seeds/thaadra = 2,
					/obj/item/seeds/gelthi = 2,
					/obj/item/seeds/mtearseed = 2,
					/obj/item/seeds/shandseed = 2,
					/obj/item/seeds/pineappleseed = 2,
					)

	contraband = list(
					/obj/item/seeds/amanitamycelium = 2,
					/obj/item/seeds/glowshroom = 2,
					/obj/item/seeds/ambrosiavulgarisseed = 2,
					/obj/item/seeds/libertymycelium = 2,
					/obj/item/seeds/nettleseed = 2,
					/obj/item/seeds/reishimycelium = 2,
					/obj/item/seeds/reishimycelium = 2,
					/obj/item/seeds/jurlmah = 2,
					/obj/item/seeds/amauri = 2,
					/obj/item/seeds/vale = 2,
					/obj/item/seeds/surik = 2,
					/obj/item/seeds/telriis = 2,
					 )
	auto_price = FALSE

/**
 * Populate hydroseeds product_records
 *
 * This needs to be customized to fetch the actual names of the seeds, otherwise
 * the machine would simply list "packet of seeds" times 20
 */

/obj/machinery/vending/hydroseeds/build_inventory()
	var/list/all_products = list(
		list(products, CAT_NORMAL),
		list(contraband, CAT_HIDDEN),
		list(premium, CAT_COIN))

	for(var/current_list in all_products)
		var/category = current_list[2]

		for(var/entry in current_list[1])
			var/obj/item/seeds/S = new entry(src)
			var/name = S.name
			var/datum/data/vending_product/product = new/datum/data/vending_product(src, entry, name)

			product.price = (entry in prices) ? prices[entry] : product.price
			product.amount = (current_list[1][entry]) ? current_list[1][entry] : 1
			product.category = category

			product_records.Add(product)
			qdel(S)


/obj/machinery/vending/dinnerware
	name = "Delta Dinnerware Express"
	desc = "A kitchen and restaurant equipment vendor."
	product_ads = "Mm, food stuffs!;Food and food accessories.;Get your plates!;You like forks?;I like forks.;Woo, utensils.;You don't really need these...;Need knives? Got you covered."
	icon_state = "dinnerware"
	products = list(/obj/item/tray = 8,
					/obj/item/material/kitchen/utensil/fork = 6,
					/obj/item/tool/knife = 6,
					/obj/item/material/kitchen/utensil/spoon = 6,
					/obj/item/material/kitchen/rollingpin = 3,
					/obj/item/reagent_containers/glass/rag = 5,
					/obj/item/reagent_containers/food/drinks/drinkingglass = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shot = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/mug = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/pint = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/wineglass = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/doble = 15,
					/obj/item/clothing/suit/rank/chef/classic = 2,
					/obj/item/clothing/suit/storage/helltaker_apron = 2,
					/obj/item/storage/lunchbox = 3,
					/obj/item/storage/lunchbox/rainbow = 3,
					/obj/item/storage/lunchbox/cat = 3,
					/obj/item/storage/lunchbox/lemniscate = 5,
					/obj/item/reagent_containers/food/drinks/pitcher = 3,
					/obj/item/reagent_containers/food/drinks/teapot = 3,
					/obj/item/reagent_containers/food/drinks/mug = 3,
					/obj/item/reagent_containers/food/drinks/mug/black = 3,
					/obj/item/reagent_containers/food/drinks/mug/green = 3,
					/obj/item/reagent_containers/food/drinks/mug/blue = 3,
					/obj/item/reagent_containers/food/drinks/mug/red = 3,
					/obj/item/reagent_containers/food/drinks/mug/heart = 3,
					/obj/item/reagent_containers/food/drinks/mug/one = 3,
					/obj/item/reagent_containers/food/drinks/mug/metal = 3,
					/obj/item/reagent_containers/food/drinks/mug/rainbow = 3,
					/obj/item/reagent_containers/food/drinks/mug/brit = 3,
					/obj/item/reagent_containers/food/drinks/mug/moebius = 3,
					/obj/item/reagent_containers/food/drinks/mug/teacup = 10,
					/obj/item/reagent_containers/food/condiment/pack/ketchup = 10,
					/obj/item/reagent_containers/food/condiment/pack/milk = 10,
					/obj/item/reagent_containers/food/condiment/pack/sugar = 10,
					/obj/item/reagent_containers/food/condiment/pack/hotsauce = 10)
	contraband = list(/obj/item/tool/knife/butch = 2)
	auto_price = FALSE
	always_open = TRUE

/obj/machinery/vending/dinnerware/cost //So we can place these around and charge people
	name = "Dinnerware Express"
	desc = "A kitchen and restaurant equipment vendor."
	product_ads = "Mm, food stuffs!;Food and food accessories.;Get your plates!;You like forks?;I like forks.;Woo, utensils.;You don't really need these...;Need knives? Got you covered."
	icon_state = "dinnerware"
	products = list(
					/obj/item/tray = 8,
					/obj/item/material/kitchen/utensil/fork = 6,
					/obj/item/tool/knife = 6,
					/obj/item/material/kitchen/utensil/spoon = 6,
					/obj/item/material/kitchen/rollingpin = 3,
					/obj/item/reagent_containers/glass/rag = 5,
					/obj/item/reagent_containers/food/drinks/drinkingglass = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shot = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/mug = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/pint = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/wineglass = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/doble = 8,
					/obj/item/clothing/suit/rank/chef/classic = 2,
					/obj/item/clothing/suit/storage/helltaker_apron = 2,
					/obj/item/storage/lunchbox = 3,
					/obj/item/storage/lunchbox/rainbow = 3,
					/obj/item/storage/lunchbox/cat = 3,
					/obj/item/reagent_containers/food/drinks/pitcher = 3,
					/obj/item/reagent_containers/food/drinks/teapot = 3,
					/obj/item/reagent_containers/food/drinks/mug/black = 3,
					/obj/item/reagent_containers/food/drinks/mug/green = 3,
					/obj/item/reagent_containers/food/drinks/mug/blue = 3,
					/obj/item/reagent_containers/food/drinks/mug/red = 3,
					/obj/item/reagent_containers/food/drinks/mug/heart = 3,
					/obj/item/reagent_containers/food/drinks/mug/one = 3,
					/obj/item/reagent_containers/food/drinks/mug/metal = 3,
					/obj/item/reagent_containers/food/drinks/mug/rainbow = 3,
					/obj/item/reagent_containers/food/drinks/mug/brit = 3,
					/obj/item/reagent_containers/food/drinks/mug/moebius = 3,
					/obj/item/reagent_containers/food/drinks/mug = 3,
					/obj/item/reagent_containers/food/drinks/mug/white = 3,
					/obj/item/reagent_containers/food/drinks/mug/teacup = 10,
					/obj/item/reagent_containers/food/condiment/pack/ketchup = 10,
					/obj/item/reagent_containers/food/condiment/pack/milk = 10,
					/obj/item/reagent_containers/food/condiment/pack/sugar = 10,
					/obj/item/reagent_containers/food/condiment/pack/hotsauce = 10)
	contraband = list(/obj/item/tool/knife/butch = 2)
	prices = list(/obj/item/tray = 35,
					/obj/item/material/kitchen/utensil/fork = 3,
					/obj/item/tool/knife = 35,
					/obj/item/material/kitchen/utensil/spoon = 3,
					/obj/item/material/kitchen/rollingpin = 9,
					/obj/item/reagent_containers/glass/rag = 15,
					/obj/item/reagent_containers/food/drinks/drinkingglass = 1,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shot = 1,
					/obj/item/reagent_containers/food/drinks/drinkingglass/mug = 1,
					/obj/item/reagent_containers/food/drinks/drinkingglass/pint = 1,
					/obj/item/reagent_containers/food/drinks/drinkingglass/wineglass = 3,
					/obj/item/reagent_containers/food/drinks/drinkingglass/doble = 2,
					/obj/item/clothing/suit/rank/chef/classic = 50,
					/obj/item/clothing/suit/storage/helltaker_apron = 50,
					/obj/item/storage/lunchbox = 8,
					/obj/item/storage/lunchbox/rainbow = 8,
					/obj/item/storage/lunchbox/cat = 8,
					/obj/item/reagent_containers/food/drinks/pitcher = 9,
					/obj/item/reagent_containers/food/drinks/teapot = 9,
					/obj/item/reagent_containers/food/drinks/mug = 6,
					/obj/item/reagent_containers/food/drinks/mug/black = 6,
					/obj/item/reagent_containers/food/drinks/mug/green = 6,
					/obj/item/reagent_containers/food/drinks/mug/blue = 6,
					/obj/item/reagent_containers/food/drinks/mug/red = 6,
					/obj/item/reagent_containers/food/drinks/mug/heart = 6,
					/obj/item/reagent_containers/food/drinks/mug/one = 6,
					/obj/item/reagent_containers/food/drinks/mug/metal = 6,
					/obj/item/reagent_containers/food/drinks/mug/rainbow = 6,
					/obj/item/reagent_containers/food/drinks/mug/brit = 6,
					/obj/item/reagent_containers/food/drinks/mug/moebius = 7,
					/obj/item/reagent_containers/food/drinks/mug/teacup = 10,
					/obj/item/reagent_containers/food/condiment/pack/ketchup = 3,
					/obj/item/reagent_containers/food/condiment/pack/milk = 3,
					/obj/item/reagent_containers/food/condiment/pack/sugar = 3,
					/obj/item/reagent_containers/food/condiment/pack/hotsauce = 3,
					/obj/item/tool/knife/butch = 55)
	auto_price = TRUE
	always_open = FALSE


/obj/machinery/vending/sovietsoda
	name = "Napitki Starogo Sveta"
	desc = "A machine filled with odd and strange pre-solfed drinks. Made fresh in the colony."
	icon_state = "sovietsoda"
	product_slogans = "For a little bit of home.;Ethnic drinks made fresh in the lower colony!"
	product_ads = "Need a strange drink? Tired of that space cola? Try one of our Ethnic drinks!;Fresh drinks, all home made in the colony.;Homemade drinks for people who want something special."
	products = list(/obj/item/reagent_containers/food/drinks/bottle/small/kvass = 10,
					/obj/item/reagent_containers/food/drinks/cans/melonsoda = 8,
					/obj/item/reagent_containers/food/drinks/drinkingglass/soda = 10)
	prices = list(/obj/item/reagent_containers/food/drinks/bottle/small/kvass = 30,
					/obj/item/reagent_containers/food/drinks/cans/melonsoda =20,
					/obj/item/reagent_containers/food/drinks/drinkingglass/soda = 10)
	contraband = list(/obj/item/reagent_containers/food/drinks/drinkingglass/cola = 20)
	idle_power_usage = 211 //refrigerator - believe it or not, this is actually the average power consumption of a refrigerated vending machine according to NRCan.
	auto_price = FALSE

/obj/machinery/vending/sovietsoda/postvend_effect()
	playsound(loc, 'sound/machines/vending_coffee.ogg', 100, 1)
	return

/obj/machinery/vending/fitness
	name = "SweatMAX"
	desc = "Fueled by your inner inadequacy!"
	product_ads = "Keep working on those gains!;No pain, no gain!;Don't weight - buy today!"
	icon_state = "fitness"
	products = list(
		/obj/item/reagent_containers/food/snacks/candy/proteinbar = 2,
		/obj/item/reagent_containers/food/snacks/openable/liquidfood = 3,
		/obj/item/reagent_containers/food/drinks/milk/small = 3,
		/obj/item/reagent_containers/food/drinks/cocamilk/small = 3,
		/obj/item/reagent_containers/food/drinks/redmilk/small = 3,
		/obj/item/reagent_containers/food/drinks/soymilk/small = 2,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 10,
		/obj/item/reagent_containers/food/snacks/candy_drop_blue = 1,
		/obj/item/reagent_containers/food/snacks/candy/energybar = 2,
		/obj/item/towel/random = 8)
	prices = list(
		/obj/item/reagent_containers/food/snacks/candy/proteinbar = 20,
		/obj/item/reagent_containers/food/snacks/openable/liquidfood = 20,
		/obj/item/reagent_containers/food/drinks/milk/small = 15,
		/obj/item/reagent_containers/food/drinks/cocamilk/small = 40,
		/obj/item/reagent_containers/food/drinks/redmilk/small = 40,
		/obj/item/reagent_containers/food/drinks/soymilk/small = 50,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 16,
		/obj/item/reagent_containers/food/snacks/candy_drop_blue = 90,
		/obj/item/reagent_containers/food/snacks/candy/energybar = 90,
		/obj/item/towel/random = 10)

/obj/machinery/vending/drink_showcase
	name = "Bar Cocktail Showcase"
	desc = "A vending machine to showcase cocktails."
	icon_state = "showcase"
	var/icon_fill = "showcase-fill"
	vend_delay = 15
	idle_power_usage = 211 //refrigerator - believe it or not, this is actually the average power consumption of a refrigerated vending machine according to NRCan.
	vendor_department = DEPARTMENT_LSS
	custom_vendor = TRUE
	can_stock = list(/obj/item/reagent_containers/glass, /obj/item/reagent_containers/food/drinks, /obj/item/reagent_containers/food/condiment)

/obj/machinery/vending/drink_showcase/update_icon()
	..()
	if(contents.len && !(stat & NOPOWER))
		overlays += image(icon, icon_fill)