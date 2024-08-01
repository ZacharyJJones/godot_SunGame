extends Control

@export var policy_type_magnitude_prefab : PackedScene



@onready var game = $"/root/GameManager".core




# ===========

@onready var enum_keys = Enum.PolicyType.keys()

# ===========
# UI Elements
# ===========
@onready var game_state = $RulesReference/GameStateArea/GameState

# Drafts / Active Policies Area
@onready var drafts_list = $DraftsAndActive/DraftItemList
@onready var active_policy_item_list = $DraftsAndActive/ActivePolicyItemList

# Event Info Area
@onready var event_details_area = $Event/EventDetailsArea
@onready var event_name = $Event/EventDetailsArea/EventName
@onready var event_thresholds_area = $Event/EventDetailsArea/EventThresholdsArea


@onready var event_policy_threshold_prefab

# Society Info Area
@onready var health_readout = $SocietyInfo/HealthReadout
@onready var health_bar = $SocietyInfo/HealthBar

@onready var turns_readout = $SocietyInfo/TurnsReadout
@onready var turns_bar = $SocietyInfo/TurnsBar

@onready var active_policy_readout_area = $SocietyInfo/ActivePolicyReadoutArea


@onready var active_policy_prefabs = {}


func _ready():
	for i in range(1, enum_keys.size()):
		var active_type_tracker = policy_type_magnitude_prefab.instantiate()
		active_policy_readout_area.add_child(active_type_tracker)
		active_policy_prefabs[Enum.PolicyType[enum_keys[i]]] = active_type_tracker
		
		active_type_tracker.Initialize(Enum.PolicyType[enum_keys[i]])
		pass
	
	# Event
	var threshold_obj = policy_type_magnitude_prefab.instantiate()
	event_thresholds_area.add_child(threshold_obj)
	event_policy_threshold_prefab = threshold_obj
	
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
	
	var state_keys = Enum.GameState.keys()
	game_state.text = state_keys[game.State]
	
	
	Update_SocietyInfo()
	Update_DraftInfo()
	Update_ActivePolicyInfo()
	Update_EventInfo()
	pass


func Update_SocietyInfo():
	health_readout.text = "%s / %s hp" % [game.Health, game.Rules.Health_ToWin]
	health_bar.value = game.Health
	
	turns_readout.text = "%s / %s turns" % [game.Turn, game.Rules.TurnsToWin]
	turns_bar.value = game.Turn
	
	for i in range(1, enum_keys.size()):
		var enum_val = Enum.PolicyType[enum_keys[i]]
		var amount = game.GetActivePolicyTypeMagnitude(enum_val)
		active_policy_prefabs[enum_val].SetQuantity(amount)
		pass
	pass

func Update_DraftInfo():
	drafts_list.clear()
	for i in range(game.Policy_Choices.size()):
		drafts_list.add_item("%s" % enum_keys[game.Policy_Choices[i].Type])
		pass
	pass

func Update_ActivePolicyInfo():
	active_policy_item_list.clear()
	for i in range(game.ActivePolicies.size()):
		active_policy_item_list.add_item("%s" % enum_keys[game.ActivePolicies[i].Type], null, false)
		pass
	pass

func Update_EventInfo():
	if not game.State == Enum.GameState.Event:
		event_details_area.set_visible(false)
		return
		
	event_details_area.set_visible(true)
	event_name.text = game.Event_Current.Name
	event_policy_threshold_prefab.SetQuantity(game.Event_Current.Magnitude)
	event_policy_threshold_prefab.Initialize(game.Event_Current.Type)
	
	pass



# Draft selection
func _on_item_list_item_activated(index):
	game.Policy_SelectedIndex = index
	var result = game.AdvanceState()
	RefreshUI()


func _on_event_continue_button_pressed():
	game.AdvanceState()
	RefreshUI()


func _on_return_menu_button_pressed():
	$"/root/GameManager".ReturnMainMenu()
