class_name Game

var Health: int
var Turn: int
var State: Enum.GameState

var Rules: GameRules

var FoundingPolicy: Enum.PolicyType
var FoundingEffects: FoundingEffectsBase

var Deck: Array
var Discard: Array
var ActivePolicies: Array
var RetiredPolicies: Array

# GameState.Policy
var Policy_Choices: Array
var Policy_SelectedIndex: int

# GameState.Event
var Event_Current: GameEvent
var Event_ActivatedPolicyIndices: Array
var Event_Rerolls: int

# ==================================

func _init(rules: GameRules):
	Rules = rules
	
	State = Enum.GameState.Undefined
	Health = Rules.Health_Starting
	Turn = 0
	
	Deck = []
	Discard = []
	ActivePolicies = []
	RetiredPolicies = []
	FoundingPolicy = Enum.PolicyType.Undefined
	FoundingEffects = FoundingEffectsBase.new()
	
	Policy_Choices = []
	Event_ActivatedPolicyIndices = []
	Event_Rerolls = 0
	
	_beginState_Founding()
	pass

# ==================================

func AdvanceState() -> bool:
	var _state_map = {
		Enum.GameState.Won: [ func(): return false, func(): return ],
		Enum.GameState.Lost: [ func(): return false, func(): return ],
		
		Enum.GameState.Founding: [_endState_Founding, _beginState_Setup],
		Enum.GameState.Setup: [_endState_Setup, _beginState_Event],
		
		Enum.GameState.Policy: [_endState_Policy, _beginState_Event],
		Enum.GameState.Event: [_endState_Event, _beginState_Policy]
	}
	
	var result = false
	if _state_map[State][0].call():
		result = true
	
	# This check goes here BECAUSE it prevents the next state from...
	# ... executing it's setup code when the game has ended. e.g. Draft choices
	# ... will not be presented going from Event -> Won/Lost State -> Policy phase
	if not IsOver():
		if (Health >= Rules.Health_ToWin
			or Turn >= Rules.TurnsToWin):
			State = Enum.GameState.Won
		if Health <= 0:
			State = Enum.GameState.Lost
		pass
	
	if result:
		_state_map[State][1].call()
	
	
	return result

func _beginState_Founding():
	State = Enum.GameState.Founding
	Policy_SelectedIndex = -1
	var vals = Enum.PolicyType.values()
	for i in range(2, vals.size()):
		Policy_Choices.append(Policy.new(vals[i]))
	pass
func _endState_Founding() -> bool:
	if not _endState_Policy():
		return false
	
	# cleanup, since I hacked the policy phase to do this
	Discard.clear()
	
	# Take the choice and set as founding!
	FoundingPolicy = ActivePolicies.pop_back().Type
	FoundingEffects = FoundingEffectsBase.GetFoundingEffects(FoundingPolicy)
	
	# Now set up the deck
	Deck = GameContent.GetStartingDeck(FoundingPolicy)
	Deck.shuffle()
	return true

func _beginState_Setup():
	_beginState_Policy()
	State = Enum.GameState.Setup
func _endState_Setup() -> bool:
	if not _endState_Policy(): return false
	if ActivePolicies.size() < GetMaxActivePolicies():
		_beginState_Setup()
		return false
	return true
	
func _beginState_Policy():
	State = Enum.GameState.Policy
	Policy_SelectedIndex = -1
	
	while Policy_Choices.size() < Rules.PoliciesDrawnDrafting:
		Policy_Choices.append(Deck.pop_front())
		if Deck.size() == 0:
			Discard.shuffle()
			Deck = Discard
			Discard = []
	pass
func _endState_Policy() -> bool:
	if Policy_SelectedIndex == -1:
		return false
	
	# Move chosen policy to active zone
	var chosen = Policy_Choices.pop_at(Policy_SelectedIndex)
	FoundingEffects.OnPolicyDraft(self, chosen)
	ActivePolicies.push_front(chosen)
	
	# Discard others
	for i in range(Policy_Choices.size()):
		Discard.append(Policy_Choices.pop_back())
	
	# Enforce policy track slots restriction
	while ActivePolicies.size() > GetMaxActivePolicies():
		var retired = ActivePolicies.pop_back()
		FoundingEffects.OnPolicyExpire(self, retired)
		RetiredPolicies.append(retired)
	
	return true
	
func _beginState_Event():
	Turn += 1
	Event_Current = _generateEvent()
	State = Enum.GameState.Event
	pass
func _endState_Event() -> bool:
	var active_of_type = GetActivePolicyTypeMagnitude(Event_Current.Type)
	var event_magnitude = EventMagnitudeWithModifiers()
	if active_of_type >= event_magnitude:
		Health += Event_Current.Reward
	else:
		Health -= (event_magnitude - active_of_type)
	
	# Mark and clear activated policies
	for i in range(Event_ActivatedPolicyIndices.size()):
		ActivePolicies[Event_ActivatedPolicyIndices[i]].HasBeenActivated = true
	Event_ActivatedPolicyIndices.clear()
	
	return true


# ==================================

func GetActivePolicyTypeMagnitude(type: Enum.PolicyType):
	var total = 0
	for i in range(ActivePolicies.size()):
		var policy = ActivePolicies[i]
		if policy.Type == type: total += 1
		if not policy.HasBeenActivated and Event_ActivatedPolicyIndices.any(func(x): return x == i):
			if policy.ActivatedType == type or policy.ActivatedType == Enum.PolicyType.All: total += 1
	return total

func RerollEvent():
	if Event_Rerolls < 1: return
	Event_Current = _generateEvent()
	Event_Rerolls -= 1

func _generateEvent() -> GameEvent:
	return FoundingEffects.ModifyEvent(self, GameContent.GenerateEvent())

# ==================================

func EventMagnitudeWithModifiers() -> int:
	return Event_Current.Magnitude + FoundingEffects.EventMagnitudeModifier(self)

func IsWon() -> bool: return State == Enum.GameState.Won
func IsLost() -> bool: return State == Enum.GameState.Lost
func IsOver() -> bool: return IsWon() or IsLost()

func GetMaxActivePolicies() -> int:
	return Rules.PolicyTrackSlots + FoundingEffects.MaxActivePolicyModifier(self)
