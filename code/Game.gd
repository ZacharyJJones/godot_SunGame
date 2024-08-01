class_name Game

var Health : int
var Turn : int
var State : Enum.GameState

var Rules : GameRules

var Deck : Array
var Discard : Array
var ActivePolicies : Array
var RetiredPolicies : Array

# GameState.Policy
var Policy_Choices : Array
var Policy_SelectedIndex : int

# GameState.Event
var Event_Current : GameEvent

# ==================================

func _init(rules : GameRules):
	State = Enum.GameState.Undefined
	Rules = rules
	Turn = 0
	
	Health = Rules.Health_Starting
	ActivePolicies = []
	RetiredPolicies = []
	
	Deck = []
	Discard = []
	Policy_Choices = []
	
	_beginState_Setup()
	pass

# ==================================

func AdvanceState() -> bool:
	var _state_map = {
		Enum.GameState.Won: [func(): return false, func(): return],
		Enum.GameState.Lost: [func(): return false, func(): return],
				
		Enum.GameState.Setup: [_endState_Setup, _beginState_Event],
		Enum.GameState.Policy: [_endState_Policy, _beginState_Event],
		Enum.GameState.Event: [_endState_Event, _beginState_Policy]		
	}
	
	var result = false
	if _state_map[State][0].call():
		_state_map[State][1].call()
		result = true
		pass
	
	if not IsOver():
		if (Health >= Rules.Health_ToWin 
			or Turn >= Rules.TurnsToWin):
			State = Enum.GameState.Won
		if Health <= 0:
			State = Enum.GameState.Lost		
		pass
	
	return result

func _beginState_Setup():
	_beginState_Policy()
	State = Enum.GameState.Setup
func _endState_Setup() -> bool:
	if not _endState_Policy():
		return false
	
	if ActivePolicies.size() < Rules.PolicyTrackSlots:
		_beginState_Setup()
		return false
	
	return true
	
func _beginState_Policy():
	State = Enum.GameState.Policy
	Policy_SelectedIndex = -1
	
	# temp options provided
	var enum_keys = Enum.PolicyType.keys()
	for i in range(1, enum_keys.size()):
		Policy_Choices.append(Policy.new(Enum.PolicyType[enum_keys[i]]))
		pass
	
	# Enforce policy track slots restriction
	#while Policy_Choices.size() < Rules.PoliciesDrawnWhenChoosing:
		#Policy_Choices.append(Deck.pop_front())
	
	pass
func _endState_Policy() -> bool:
	if Policy_SelectedIndex == -1:
		return false
	
	# Resolve chosen policy
	ActivePolicies.push_front(Policy_Choices.pop_at(Policy_SelectedIndex))
	for i in range(Policy_Choices.size()):
		Discard.append(Policy_Choices.pop_back())
	
	# Enforce policy track slots restriction
	while ActivePolicies.size() > Rules.PolicyTrackSlots:
		RetiredPolicies.append(ActivePolicies.pop_back())
	
	return true
	
func _beginState_Event():
	Turn += 1
	State = Enum.GameState.Event
	Event_Current = GameContent.GenerateEvent()
	pass
func _endState_Event() -> bool:
	var active_of_type = GetActivePolicyTypeMagnitude(Event_Current.Type)
	if active_of_type >= Event_Current.Magnitude:
		Health += Event_Current.Magnitude
	else:
		Health -= (Event_Current.Magnitude - active_of_type)
	return true


# ==================================

func GetActivePolicyTypeMagnitude(type : Enum.PolicyType):
	return ActivePolicies.filter(func(p): return p.Type == type).size()

# ==================================


func IsWon() -> bool: return State == Enum.GameState.Won
func IsLost() -> bool: return State == Enum.GameState.Lost
func IsOver() -> bool: return IsWon() or IsLost()







