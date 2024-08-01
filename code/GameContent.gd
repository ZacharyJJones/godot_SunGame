class_name GameContent




static func GenerateEvent() -> GameEvent:
	var keys_defined = Enum.PolicyType.keys().slice(1)
	var type = Enum.PolicyType[keys_defined[randi() % keys_defined.size()]]
	
	var magnitude = 1 + (randi() % 4)
	var name = "%s %s" % [
		_adjectives[randi() % _adjectives.size()], 
		_nouns[randi() % _nouns.size()]
	]
	return GameEvent.new(name, type, magnitude)


static func GetStartingDeck(founding_type):
	var num_basic_policies = 8
	var num_active_policies = 1
	var num_wildcards = 1
	var deck = []
	
	var type_values = Enum.PolicyType.values()	
	for n in range(num_wildcards + 1):
		deck.append(Policy.new(founding_type, type_values.slice(1)))
		
	deck.append_array(_get_deck_helper(founding_type, type_values, num_basic_policies, num_active_policies))
		
	for i in range(1, type_values.size()):
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
