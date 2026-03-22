extends Control


@onready var game : Game = $"/root/GameManager".core
@onready var game_manager = $"/root/GameManager"

@onready var _enum_keys = Enum.PolicyType.keys()


# References to UI sections
@onready var SocietyBar = $"SocietyBar"

@onready var FoundingSocietyView = $"FoundingSocietyView"
@onready var PolicyDraftView = $"PolicyDraftView"
@onready var EventOutcomeView = $"EventOutcomeView"

@onready var PolicyTrack = $"PolicyTrack"


# 
@export var ActivePolicyTemplate : PackedScene
@onready var ActivePolicyArea : BoxContainer = $"PolicyTrack/ScrollContainer/ActivePolicyHbox"


# this could be an export but feels unnecessary. Was just some basic
# ... layout changes, not worth making it's own file(?)
var _policySelectionButtonTemplate : PackedScene


# ---------------------------------------------

# Called when the node enters the scene tree for the first time.
func _ready():
	_policySelectionButtonTemplate = _get_node_as_template($"PolicyDraftView/HBox_Buttons/Button", true)
	
	
	# == Special One-Off Setup For Founding Phase ==
	_ui_set_active_view(game.State)
	
	$"FoundingSocietyView/HBox/War".connect("pressed", func(): _btn_select_founding_policy(Enum.PolicyType.War))
	$"FoundingSocietyView/HBox/Peace".connect("pressed", func(): _btn_select_founding_policy(Enum.PolicyType.Peace))
	$"FoundingSocietyView/HBox/Science".connect("pressed", func(): _btn_select_founding_policy(Enum.PolicyType.Science))
	$"FoundingSocietyView/HBox/Faith".connect("pressed", func(): _btn_select_founding_policy(Enum.PolicyType.Faith))
	
	$"FoundingSocietyView/HBox/War/Desc".text = _get_founding_effect_hint(Enum.PolicyType.War)
	$"FoundingSocietyView/HBox/Peace/Desc".text = _get_founding_effect_hint(Enum.PolicyType.Peace)
	$"FoundingSocietyView/HBox/Science/Desc".text = _get_founding_effect_hint(Enum.PolicyType.Science)
	$"FoundingSocietyView/HBox/Faith/Desc".text = _get_founding_effect_hint(Enum.PolicyType.Faith)
	pass


func RefreshUI():
	# a lot of this doesn't change as every time and could(?) be done elsewhere
	# ... but is MUCH simpler to just set up here and call every time.
	_ui_set_active_view() 
	
	
	RefreshUI_DraftingPolicies()
	# RefreshUI_EventOutcomeChoice()
	RefreshUI_ActivePolicies()
	pass

func RefreshUI_DraftingPolicies():
	var policies_area = $"PolicyDraftView/HBox_Policies"
	var buttons_area = $"PolicyDraftView/HBox_Buttons"
	
	# Clear Existing Stuff
	var current_tiles = policies_area.get_children()
	for i in range(current_tiles.size()):
		current_tiles[i].queue_free()
	var current_buttons = buttons_area.get_children()
	for i in range(current_buttons.size()):
		current_buttons[i].queue_free()
		
	# Make the desired things
	for i in range(game.Policy_Choices.size()):
		# Add policy tile
		var policy_node = ActivePolicyTemplate.instantiate()
		policies_area.add_child(policy_node)
		policy_node.SetPolicyInfo(game.Policy_Choices[i])
		
		# Add corresponding button
		var new_button : Button = _policySelectionButtonTemplate.instantiate()
		new_button.connect("pressed", func(): _btn_select_policy_to_draft(i))
		buttons_area.add_child(new_button)
	pass

func RefreshUI_EventOutcomeChoice():
	pass

func RefreshUI_ActivePolicies():
	var currentTiles = ActivePolicyArea.get_children()
	for i in range(currentTiles.size()):
		currentTiles[i].queue_free()
	
	var actives = game.ActivePolicies
	var size = actives.size()
	for i in range(size):
		var policy_node = ActivePolicyTemplate.instantiate()
		ActivePolicyArea.add_child(policy_node)
		policy_node.SetPolicyInfo(actives[size - 1 - i])
	pass

# ---------------------------------------------

func _ui_set_active_view(state : Enum.GameState = Enum.GameState.Undefined):
	if (state == Enum.GameState.Undefined):
		state = game.State
	
	SocietyBar.visible = true
	ActivePolicyArea.visible = true
	
	FoundingSocietyView.visible = false
	PolicyDraftView.visible = false
	EventOutcomeView.visible = false
	
	if (game.State == Enum.GameState.Founding):
		SocietyBar.visible = false
		ActivePolicyArea.visible = false
		FoundingSocietyView.visible = true
	if (game.State == Enum.GameState.Setup):
		PolicyDraftView.visible = true
	if (game.State == Enum.GameState.Policy):
		PolicyDraftView.visible = true
	if (game.State == Enum.GameState.Event):
		EventOutcomeView.visible = true
	pass

func _btn_select_founding_policy(type : Enum.PolicyType):
	game.FoundingPolicy = type
	game.AdvanceState()
	
	# One-off UI changes here due to selection
	var foundingPolicyIcon = $"SocietyBar/FoundingPolicyIcon"
	foundingPolicyIcon.set_texture(game_manager.PolicyIcons[type])
	foundingPolicyIcon.modulate = game_manager.PolicyColors[type]
	foundingPolicyIcon.tooltip_text = _get_founding_effect_hint(game.FoundingPolicy)
	
	RefreshUI()
	pass

func _btn_select_policy_to_draft(index : int):
	game.Policy_SelectedIndex = index
	game.AdvanceState()
	RefreshUI()
	pass

func _get_founding_effect_hint(type : Enum.PolicyType) -> String:
	var map = {
		Enum.PolicyType.Undefined: "",
		Enum.PolicyType.War: "With 2+ active War effect:\nEvent magnitude reduced by 1.\n(Activated policies count)",
		Enum.PolicyType.Peace: "With 2+ active Peace policies:\n+1 active policy limit.",
		Enum.PolicyType.Science: "When Science policy expires:\nGain 1 reroll credit (max 1).",
		Enum.PolicyType.Faith: "Faith policies which can be activated\nwill grant ALL types.",
	}
	return map[type]

func _get_node_as_template(node : Node, delete_after : bool = false):
	var scene = PackedScene.new()
	scene.pack(node)
	
	if (delete_after):
		node.queue_free()
	return scene
