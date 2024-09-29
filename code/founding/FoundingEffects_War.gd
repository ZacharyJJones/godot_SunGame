extends FoundingEffectsBase

class_name FoundingEffects_War

func EventMagnitudeModifier(game : Game) -> int:
	if game.GetActivePolicyTypeMagnitude(Enum.PolicyType.War) >= 2:
		return -1
	return 0
