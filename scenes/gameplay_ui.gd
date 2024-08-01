extends Control

@export var policy_type_display_prefab : PackedScene




@onready var game = $"/root/GameManager".core

# ===========

@onready var _enum_keys = Enum.PolicyType.keys()

# ===========
# UI Elements
# ===========
@onready var game_state = $RulesReference/GameStateArea/GameState
@onready var founding_policy_frame = $RulesReference/FoundingPolicyFrame
var founding_policy_prefab

# Drafts / Active Policies Area
@onready var drafts_list = $DraftsAndActive/DraftItemList
@onready var active_policy_item_list = $DraftsAndActive/ActivePolicyItemList

# Event Info Area
@onready var event_details_area = $Event/EventDetailsArea
@onready var event_name = $Event/EventDetailsArea/EventName
@onready var event_thresholds_area = $Event/EventDetailsArea/EventThresholdsArea

@onready var event_reroll_button = $Event/EventDetailsArea/EventRerollButton


@onready var event_policy_threshold_prefab

# Society Info Area
@onready var health_readout = $SocietyInfo/HealthReadout
@onready var health_bar = $SocietyInfo/HealthBar

@onready var turns_readout = $SocietyInfo/TurnsReadout
@onready var turns_bar = $SocietyInfo/TurnsBar

@onready var active_policy_readout_area = $SocietyInfo/ActivePolicyReadoutArea
var active_policy_prefabs


func _ready():
	active_policy_prefabs = {}
	for i in range(1, _enum_keys.size()):
		var active_type_tracker = policy_type_display_prefab.instantiate()
		active_policy_readout_area.add_child(active_type_tracker)
		active_policy_prefabs[Enum.PolicyType[_enum_keys[i]]] = active_type_tracker
		
		active_type_tracker.Initialize(Enum.PolicyType[_enum_keys[i]])
		pass
	
	# Event
	var threshold_obj = policy_type_display_prefab.instantiate()
	event_thresholds_area.add_child(threshold_obj)
	event_policy_threshold_prefab = threshold_obj
	
	var founding_obj = policy_type_display_prefab.instantiate()
	founding_policy_frame.add_child(founding_obj)
	founding_policy_prefab = founding_obj
	founding_obj.set_visible(false)
	
	RefreshUI()

# Full refresh for UI
func RefreshUI():
	var max_hp = game.Rules.Health_ToWin
	health_bar.max_value = max_hp
	health_bar.tick_count = roundi(max_hp / 5) + 1
	
	var turns = game.Rules.TurnsToWin
	turns_bar.max_value = turns
	if (turns <= 20):
		turns_bar.tick_count = turns + 1
	else:
		turns_bar.tick_count = 6
		
	RefreshUI_Society()
	RefreshUI_Drafts()
	RefreshUI_ActivePolicy()
	RefreshUI_Event()
	RefreshUI_Etc()
	pass


func RefreshUI_Society():
	health_readout.text = "%s / %s hp" % [game.Health, game.Rules.Health_ToWin]
	health_bar.value = game.Health
	
	turns_readout.text = "%s / %s turns" % [game.Turn, game.Rules.TurnsToWin]
	turns_bar.value = game.Turn
	
	for i in range(1, _enum_keys.size()):
		var enum_val = Enum.PolicyType[_enum_keys[i]]
		var amount = game.GetActivePolicyTypeMagnitude(enum_val)
		active_policy_prefabs[enum_val].SetLabel(amount)
		pass
	pass

func RefreshUI_Drafts():
	drafts_list.clear()
	for i in range(game.Policy_Choices.size()):
		drafts_list.add_item(_policy_as_str(game.Policy_Choices[i]))
		pass
	pass

func RefreshUI_ActivePolicy():
	active_policy_item_list.clear()
	for i in range(game.ActivePolicies.size()):
		active_policy_item_list.add_item(
			_policy_as_str(game.ActivePolicies[i])
		)
		if not game.ActivePolicies[i].CanBeActivated():
			active_policy_item_list.set_item_disabled(i, true)
		pass
	pass

func RefreshUI_Event():
	if not game.State == Enum.GameState.Event:
		event_details_area.set_visible(false)
		return
	
	event_reroll_button.set_visible(game.Event_Rerolls > 0)
		
	event_details_area.set_visible(true)
	event_name.text = game.Event_Current.Name
	event_policy_threshold_prefab.SetLabel(game.Event_Current.Magnitude)
	event_policy_threshold_prefab.Initialize(game.Event_Current.Type)
	
	pass

func RefreshUI_Etc():
	var state_keys = Enum.GameState.keys()
	game_state.text = state_keys[game.State]
	
	if (game.State != Enum.GameState.Founding):
		founding_policy_prefab.set_visible(true)
		founding_policy_prefab.Initialize(game.FoundingPolicy)
		founding_policy_prefab.SetLabel("Founding")
	
	pass

# ======================================================

func _policy_as_str(policy : Policy):
	var active_types = ""
	if (policy.ActivatedTypes.size() > 0):
		active_types = " (%s)" % ", ".join(policy.ActivatedTypes.map(func(x): return _enum_keys[x]))
	return "%s%s" % [_enum_keys[policy.Type], active_types]

# ======================================================

# Draft selection
func _on_draft_item_list_item_activated(index):
	game.Policy_SelectedIndex = index
	var result = game.AdvanceState()
	RefreshUI()

func _on_return_menu_button_pressed():
	$"/root/GameManager".ReturnMainMenu()
	
func _on_event_reroll_button_pressed():
	game.RerollEvent()
	RefreshUI_Event()

func _on_event_continue_button_pressed():
	game.AdvanceState()
	RefreshUI()

# when active policies are selected (to be activated)
func _on_active_policy_item_list_multi_selected(index, selected):
	if (game.State == Enum.GameState.Event):
		game.Event_ActivatedPolicyIndices = active_policy_item_list.get_selected_items()
		RefreshUI_Society()

