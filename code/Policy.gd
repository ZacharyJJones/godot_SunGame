class_name Policy

var Type : Enum.PolicyType
var ActivatedTypes : Array
var HasBeenActivated : bool

func _init(type, activated = []):
	Type = type
	ActivatedTypes = activated
	HasBeenActivated = false

func CanBeActivated():
	return not HasBeenActivated and ActivatedTypes.size() > 0
