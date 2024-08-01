class_name GameContent




static func GenerateEvent() -> GameEvent:
	var type = Enum.GetRandomDefined(Enum.PolicyType)	
	var magnitude = 1 + (randi() % 4)
	var name = "%s %s" % [
		_adjectives[randi() % _adjectives.size()], 
		_nouns[randi() % _nouns.size()]
	]
	return GameEvent.new(name, type, magnitude)





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
