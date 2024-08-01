extends FoundingEffectsBase

class_name FoundingEffects_Education

func OnPolicyDraft(game : Game, policy : Policy):
	if policy.Type == Enum.PolicyType.Education:
		policy.ActivatedTypes = Enum.PolicyType.values().slice(1)
	pass
