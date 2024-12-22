extends FoundingEffectsBase

class_name FoundingEffects_Faith

func OnPolicyDraft(_game: Game, policy: Policy):
	if policy.Type == Enum.PolicyType.Faith:
		policy.ActivatedType = Enum.PolicyType.All
	pass
