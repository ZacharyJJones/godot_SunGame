extends Node3D

@export var main_menu_scene : PackedScene
@export var gameplay_scene : PackedScene

var core : Game

# Have a default in place for faster testing
func _ready():
	core = Game.new(GameRules.new())
	pass

func StartGame(rules):
	core = Game.new(rules)
	get_tree().change_scene_to_packed(gameplay_scene)
	pass

func ReturnMainMenu():
	get_tree().change_scene_to_packed(main_menu_scene)
	pass
