class_name GameEvent

var Name : String
var Type : Enum.PolicyType
var Magnitude : int
var Reward : int

func _init(name, type, magnitude):
	Name = name
	Type = type
	Magnitude = magnitude
	Reward = magnitude
	pass
