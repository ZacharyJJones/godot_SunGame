extends Panel

@onready var image_node : TextureRect = $"PolicyTypeImage"
@onready var button_node : Button = $"PolicyActivateButton"
@onready var title_node : Label = $"PolicyTitle"
@onready var desc_node : Label = $"PolicyDesc"

func SetPolicyInfo(policy : Policy):
	var game_manager = $"/root/GameManager"
	image_node.texture = game_manager.PolicyIcons[policy.Type]
	image_node.modulate = game_manager.PolicyColors[policy.Type]
	title_node.text = policy.Name
	desc_node.text = policy.Desc
	
	if (policy.ActivatedType == Enum.PolicyType.Undefined):
		button_node.visible = false
	else:
		var btn_image : TextureRect = $"PolicyActivateButton/PolicyTypeImage"
		btn_image.texture = game_manager.PolicyIcons[policy.ActivatedType]
		btn_image.modulate = game_manager.PolicyColors[policy.ActivatedType]
		pass
