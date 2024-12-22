class_name Policy

var Name: String
var Type: Enum.PolicyType
var ActivatedType: Enum.PolicyType
var HasBeenActivated: bool

func _init(type, activated_type = Enum.PolicyType.Undefined):
	Name = Enum.PolicyType.keys()[type]
	Type = type
	ActivatedType = activated_type
	HasBeenActivated = false

func CanBeActivated():
	return !HasBeenActivated and ActivatedType != Enum.PolicyType.Undefined
