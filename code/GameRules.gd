class_name GameRules


var Health_Starting : int
var Health_ToWin : int

var TurnsToWin : int

var PolicyTrackSlots : int
var PoliciesDrawnDrafting : int


func _init(
	hp_start = 10,
	hp_win = 25,
	turns_to_win = 10,
	policies_drawn = 3,
	policy_slots = 4
):
	Health_Starting = hp_start
	Health_ToWin = hp_win
	TurnsToWin = turns_to_win
	PoliciesDrawnDrafting = policies_drawn
	PolicyTrackSlots = policy_slots
	pass

# ============================

#func Serialize():
#
	#var rule = GameRules.new()
	#
	#var dict = inst_to_dict(rule)
	#var keys = dict.keys().filter(func(k): return k[0] != "@")
	#for i in keys.size():
		#print("%s: %s" % [keys[i], dict[keys[i]]])
	#
	#var obj : GameRules = dict_to_inst(dict)
	#pass
