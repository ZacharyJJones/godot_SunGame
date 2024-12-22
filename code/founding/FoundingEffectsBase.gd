class_name FoundingEffectsBase

# provided to 
static func GetFoundingEffects(founding: Enum.PolicyType) -> FoundingEffectsBase:
	var map = {
		Enum.PolicyType.War: FoundingEffects_War.new(),
		Enum.PolicyType.Peace: FoundingEffects_Peace.new(),
		Enum.PolicyType.Science: FoundingEffects_Science.new(),
		Enum.PolicyType.Faith: FoundingEffects_Faith.new()
	}
	return map[founding]
	
# ================================================

func MaxActivePolicyModifier(_game: Game) -> int:
	return 0

func ModifyEvent(_game: Game, event: GameEvent) -> GameEvent:
	return event

func EventMagnitudeModifier(_game: Game) -> int:
	return 0

func OnPolicyExpire(_game: Game, _policy: Policy):
	pass

func OnPolicyDraft(_game: Game, _policy: Policy):
	pass
