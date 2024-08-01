class_name FoundingEffectsBase

static func GetFoundingEffects(founding : Enum.PolicyType) -> FoundingEffectsBase:
	var map = {
		Enum.PolicyType.War: FoundingEffects_War.new(),
		Enum.PolicyType.Peace: FoundingEffects_Peace.new(),
		Enum.PolicyType.Science: FoundingEffects_Science.new(),
		Enum.PolicyType.Education: FoundingEffects_Education.new()
	}
	return map[founding]
	
# ================================================

func MaxActivePolicyModifier(game : Game) -> int:
	return 0

func ModifyEvent(game : Game, event : GameEvent) -> GameEvent:
	return event

func OnPolicyExpire(game : Game, policy : Policy):
	pass

func OnPolicyDraft(game : Game, policy : Policy):
	pass
