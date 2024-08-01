extends FoundingEffectsBase

class_name FoundingEffects_Science

func OnPolicyExpire(game : Game, policy : Policy):
	if policy.Type == Enum.PolicyType.Science:
		game.Event_Rerolls = 1
	pass
