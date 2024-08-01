extends FoundingEffectsBase

class_name FoundingEffects_Peace

func MaxActivePolicyModifier(game : Game) -> int:
	if game.GetActivePolicyTypeMagnitude(Enum.PolicyType.Peace) >= 2:
		return 1
	return 0
