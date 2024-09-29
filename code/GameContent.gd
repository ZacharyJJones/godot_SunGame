class_name GameContent


static func GetTrials():
	return [
		_makeEvent(
			"Really Angry Bears", 
			"A horde of bears burned to a crisp, kept alive purely by the rage contained in their furry bodies.",
			[
				_makeEventFailure("Endure the Rampage", -2),
				_makeEventSuccess("Bring low the Ursinoid", Enum.PolicyType.War, 3),
				_makeEventSuccess("Appease their Fury", Enum.PolicyType.Peace, 4)
			]
		),
		_makeEvent(
			"Crisis of Faith", 
			"The community is overwhelmed by nightmares, and fits of blindness run rampant, all despite the solar priest’s attempts to quell it.",
			[
				_makeEventFailure("Give into despair", -2),
				_makeEventSuccess("Emerge Stronger", Enum.PolicyType.Peace, 3),
				_makeEventSuccess("Adopt the Dark", Enum.PolicyType.Faith, 2)
			]
		),
		_makeEvent(
			"Smotherwitch Kidnapping", 
			"The nearby swamp's smotherwitch coven has kidnapped members of the community for a sacrificial ritual.",
			[
				_makeEventFailure("Relinquish Hope", -2),
				_makeEventSuccess("Rescue the taken", Enum.PolicyType.War, 3),
				_makeEventSuccess("Bargain for Power", Enum.PolicyType.Peace, 2)
			]
		),
		_makeEvent(
			"Elemental Font", 
			"An ancient wizard's tower begins to conjure strange and powerful elementals.",
			[
				_makeEventFailure("Wait out the Onslaught", -2),
				_makeEventSuccess("Harness the Font", Enum.PolicyType.Science, 3),
				_makeEventSuccess("Pacify the Elementals", Enum.PolicyType.Peace, 4)
			]
		),
		_makeEvent(
			"Stochastic Void", 
			"A gateway to a realm of nonexistence opens and begins wandering in the society's territory, threatening its resources and people.",
			[
				_makeEventFailure("Avoid the Abyss", -2),
				_makeEventSuccess("Unmake the Unmaker", Enum.PolicyType.Science, 4),
				_makeEventSuccess("Proclaim Annihilation", Enum.PolicyType.Faith, 1)
			]
		),
		_makeEvent(
			"Dreams of Rampage", 
			"Everpresent violent nightmares about a great horned figure have spread across the community, bringing doomsaying and distress.",
			[
				_makeEventFailure("Shun the Doubts", -2),
				_makeEventSuccess("Utilize for Solidarity", Enum.PolicyType.Peace, 2),
				_makeEventSuccess("Exploit for Visions Beyond", Enum.PolicyType.Faith, 3)
			]
		),
		_makeEvent(
			"Revision Virus", 
			"Vault exploration has released a disease that rewrites random bits of a victim's genes.",
			[
				_makeEventFailure("Isolate the Sick", -2),
				_makeEventSuccess("Genuflect Before Change", Enum.PolicyType.Faith, 2),
				_makeEventSuccess("Advance Genetics", Enum.PolicyType.Science, 3)
			]
		),
		_makeEvent(
			"Everything But Hope", 
			"Unwitting cultists rip a hole into a nightmarish dimension, releasing untold evils.",
			[
				_makeEventFailure("Embrace Exile", -2),				
				_makeEventSuccess("Bargain for Survival", Enum.PolicyType.Faith, 1),
				_makeEventSuccess("Master the Nightmare", Enum.PolicyType.Science, 4)
			]
		),
		_makeEvent(
			"Battlegod", 
			"A warrior from a neighboring community never seems to lose a conflict. They threaten your society.",
			[
				_makeEventFailure("Obsequiate", -2),
				_makeEventSuccess("Unseam the Blessing", Enum.PolicyType.Science, 2),
				_makeEventSuccess("Break the Unbroken", Enum.PolicyType.Faith, 3)
			]
		),
		_makeEvent(
			"The Call of Better Things", 
			"A larger, more prosperous society offers membership to your people, splitting the community and threatening its cohesion.",
			[
				_makeEventFailure("Allow Dissolution", -2),
				_makeEventSuccess("Assert Unity", Enum.PolicyType.Faith, 2),
				_makeEventSuccess("Fell the Giant", Enum.PolicyType.War, 4)
			]
		)
	]

static func GetOpportunities():
	return [
		_makeEvent(
			"Mines of Madness", 
			"Cursed caves are opened to the surface, offering great rewards at the risk of a mind unmade.",
			[
				_makeEventFailure("Nothing at all", 0),
				_makeEventSuccess("Brave the Mines", Enum.PolicyType.War, 2),
				_makeEventSuccess("Feed upon the Madness", Enum.PolicyType.Faith, 1)
			]
		),
		_makeEvent(
			"The Fruiting Titan", 
			"The local wandering plant behemoth is bearing fruit for the first time in decades, drawing the eyes of everyone with an empty stomach or an eager mind.",
			[
				_makeEventFailure("Nothing at all", 0),
				_makeEventSuccess("Harvest the Fruit", Enum.PolicyType.Science, 2),
				_makeEventSuccess("Harvest the Titan", Enum.PolicyType.War, 3)
			]
		),
		_makeEvent(
			"Mindblossom", 
			"A hallucinogenic invasive weed begins opening the minds of the community to realms and concepts beyond mortality.",
			[
				_makeEventFailure("Nothing at all", 0),
				_makeEventSuccess("Seek Enlightenment", Enum.PolicyType.Faith, 3),
				_makeEventSuccess("Weaponize It", Enum.PolicyType.War, 2)
			]
		),
		_makeEvent(
			"Bio-Loom", 
			"A community member happens upon an ancient biome reseeder. Infinite possibilities for new life forms lie within its tattered cradle.",
			[
				_makeEventFailure("Nothing at all", 0),
				_makeEventSuccess("Create a Garden of Harmony", Enum.PolicyType.Peace, 2),
				_makeEventSuccess("Create a Ravenous Blade", Enum.PolicyType.Science, 2)
			]
		),
		_makeEvent(
			"Word of Fire", 
			"The dying breath of a mountain hermit brings knowledge of powerful pyromancy, fomenting covetousness and danger from all who hear of it.",
			[
				_makeEventFailure("Nothing at all", 0),
				_makeEventSuccess("Spread the Word as a Seed of Discord", Enum.PolicyType.Faith, 1),
				_makeEventSuccess("Parse the Word for Esoteric Structure", Enum.PolicyType.Science, 3)
			]
		),
		_makeEvent(
			"Instantial Apotheosis", 
			"One society member begins manifesting increasingly potent sorcerous abilities. Soon they will grow beyond anyone's control.",
			[
				_makeEventFailure("Nothing at all", 0),
				_makeEventSuccess("Let the Candle Burn", Enum.PolicyType.Peace, 1),
				_makeEventSuccess("Snuff them Out", Enum.PolicyType.Faith, 1)
			]
		),
		_makeEvent(
			"The Weak Shall Disinherit", 
			"Wary refugees from a far-off war arrive, bearing strange technologies.",
			[
				_makeEventFailure("Nothing at all", 0),
				_makeEventSuccess("Take From the Conquered", Enum.PolicyType.War, 1),
				_makeEventSuccess("Shelter the Exiles", Enum.PolicyType.Peace, 2)
			]
		),
		_makeEvent(
			"Neodivinity", 
			"The world ripples with the creation of a new divine source, drawing potential adherents, avaricious eyes, and curious observers",
			[
				_makeEventFailure("Nothing at all", 0),
				_makeEventSuccess("Rise as First Disciples", Enum.PolicyType.Faith, 3),
				_makeEventSuccess("Observe and Exploit", Enum.PolicyType.Science, 3)
			]
		),
		_makeEvent(
			"The Name of a Dragon", 
			"A forgotten text reveals the true name of a dragon controlling a nearby peak.",
			[
				_makeEventFailure("Nothing at all", 0),
				_makeEventSuccess("Raze the Land", Enum.PolicyType.War, 2),
				_makeEventSuccess("Foster Peace", Enum.PolicyType.Peace, 3)
			]
		),
		_makeEvent(
			"Land of Ash", 
			"The line between the lands of the living and the dead grows thin.",
			[
				_makeEventFailure("Nothing at all", 0),
				_makeEventSuccess("Commune with Wisdom", Enum.PolicyType.Peace, 2),
				_makeEventSuccess("Cut the Line in Twain", Enum.PolicyType.Science, 3)
			]
		)
	]

static func _makeEvent(name, desc, outcomes):
	return {
		Name = name,
		Description = desc,
		Outcomes = outcomes
	}
static func _makeOutcome_base(name, hpChange, thresholds):
	return {
		Name = name,
		HpChange = hpChange,
		Thresholds = thresholds
	}
static func _makeEventFailure(name, hpChange):
	return _makeOutcome_base(name, hpChange, [])
static func _makeEventSuccess(name, type, amount):
	return _makeOutcome_base(name, amount, [{Type=type,Amount=amount}])


static func GenerateEvent() -> GameEvent:
	var keys_defined = Enum.PolicyType.keys().slice(1)
	var type = Enum.PolicyType[keys_defined[randi() % keys_defined.size()]]
	
	var magnitude = 1 + (randi() % 4)
	var name = "%s %s" % [
		_adjectives[randi() % _adjectives.size()], 
		_nouns[randi() % _nouns.size()]
	]
	return GameEvent.new(name, type, magnitude)


static func GetPolicyOptions(founding_type, quantity):
	# get the types, except "undefined"
	var type_values = Enum.PolicyType.values().slice(1)
	type_values.append(founding_type)
	
	var draft_options = []
	for i in range(mini(quantity, type_values.size())):
		
		pass
	
	
	pass

static func GetStartingDeck(founding_type):
	
	var num_basic_policies = 8
	var num_active_policies = 1
	var num_wildcards = 1
	var deck = []
	
	# get the types, except "undefined"
	var type_values = Enum.PolicyType.values().slice(1)
	
	for n in range(num_wildcards + 1):
		deck.append(Policy.new(founding_type, type_values))
		
	deck.append_array(_get_deck_helper(founding_type, type_values, num_basic_policies, num_active_policies))
		
	for i in range(type_values.size()):
		var curr_type = type_values[i]
		deck.append_array(_get_deck_helper(curr_type, type_values, num_basic_policies, num_active_policies))
				
	return deck
static func _get_deck_helper(type, types, basic, active):
	var working = []
	for n in range(basic):
		working.append(Policy.new(type, []))
	
	for n in range(active):
		for a in range(1, types.size()):
			working.append(Policy.new(type, [types[a]]))
	return working

const _adjectives : Array[String] = [
	"Red",
	"Orange",
	"Yellow",
	"Green",
	"Blue",
	"Purple",
	"Light",
	"Dark",
	"White",
	"Black",
	"Terrible",
	"Wonderful",
	"Crazy",
	"Lifeless",
	"Thunderous",
	"Mysterious",
	"Strangling",
	"Falling",
	"Strong",
	"Volcanic",
	"Otherwordly"
]

const _nouns : Array[String] = [
	"Children",
	"Nightmares",
	"Apparations",
	"Beasts",
	"Weapons",
	"War",
	"Peacetime",
	"Threats",
	"Boats",
	"Foundations",
	"Sabbath",
	"Marriage",
	"Revolution",
	"Beginnings",
	"Terrors",
	"Strangers",
	"Smotherwitches"
]
