extends FoundingEffectsBase

class_name FoundingEffects_War

func ModifyEvent(game : Game, event : GameEvent) -> GameEvent:
	if game.GetActivePolicyTypeMagnitude(Enum.PolicyType.War) >= 2:
		event.Magnitude -= 1
	return event
