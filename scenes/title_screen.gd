extends Node3D

@export var rules_setting_prefab : PackedScene

@onready var setting_nodes : Dictionary = {}
@onready var settings_list = $TitleUI/Panel/SettingsMenu/ScrollContainer/SettingsList

var rules_dict

# Called when the node enters the scene tree for the first time.
func _ready():
	rules_dict = inst_to_dict(GameRules.new())
	var keys = rules_dict.keys().filter(func(k): return !k.begins_with("@"))
	for i in range(keys.size()):
		
		var prefab = rules_setting_prefab.instantiate()
		settings_list.add_child(prefab)
		
		var label = prefab.get_node("./Hbox/Label")
		label.text = "%s:" % keys[i]
		var input = prefab.get_node("./Hbox/Input")
		input.text = "%s" % rules_dict[keys[i]]
		
		setting_nodes[keys[i]] = input
		pass
	pass # Replace with function body.




func _on_start_game_pressed():
	var keys = setting_nodes.keys()
	for i in range(keys.size()):
		rules_dict[keys[i]] = maxi(1, int(setting_nodes[keys[i]].text))
	
	var rules : GameRules = dict_to_inst(rules_dict)
	$"/root/GameManager".StartGame(rules)
