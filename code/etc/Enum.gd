class_name Enum

enum PolicyType {
	Undefined,
	All,
	
	War,
	Peace,
	Science,
	Faith
}
enum PolicyType_Fancy {
	Undefined,
	All,
	
	Catena,   # latin word "to chain"
	Symphren, # "Minds together" - Cooperation, solidarity, diplomacy
	Ergopoei, # Understanding the thing, making best use of it. Tools, taking things apart and putting them together
	Inravok   # "To call within" - Invocation, appealing to and working with other things for assistance
}

enum GameState {
	Undefined = 0,
	
	Won,
	Lost,
	
	Founding,
	Setup,
	
	Policy,
	Event
}
