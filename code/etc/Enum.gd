class_name Enum

static func GetRandomDefined(enum_name):
	var keys = enum_name.keys()
	return enum_name[keys[1 + randi() % (keys.size() - 1)]]

enum PolicyType {
	Undefined,
	
	War,
	Peace,
	Science,
	Education
}

enum GameState {
	Undefined = 0,
	
	Won,
	Lost,
	
	Setup,
	
	Policy,
	Event
}
