extends Control


@onready var game = $"/root/GameManager".core
@onready var game_manager = $"/root/GameManager"

@onready var _enum_keys = Enum.PolicyType.keys()


# References to UI sections
@onready var SocietyBar = $"SocietyBar"

@onready var FoundingSocietyView = $"FoundingSocietyView"
@onready var PolicyDraftView = $"PolicyDraftView"
@onready var EventOutcomeView = $"EventOutcomeView"

@onready var PolicyTrack = $"PolicyTrack"


# 
@export var ActivePolicyTemplate : PackedScene
@onready var ActivePolicyArea : BoxContainer = $"PolicyTrack/ActivePolicyHbox"



# ---------------------------------------------

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set visible UI for founding phase
	$"SocietyBar".visible = false
	$"PolicyTrack".visible = false
	
	$"FoundingSocietyView".visible = true
	$"PolicyDraftView".visible = false
	$"EventOutcomeView".visible = false
	
	# Set up buttons / outcomes for selecting a founding policy
	$"FoundingSocietyView/HBox/War".connect("pressed", func(): _select_founding_policy(Enum.PolicyType.War))
	$"FoundingSocietyView/HBox/Peace".connect("pressed", func(): _select_founding_policy(Enum.PolicyType.Peace))
	$"FoundingSocietyView/HBox/Science".connect("pressed", func(): _select_founding_policy(Enum.PolicyType.Science))
	$"FoundingSocietyView/HBox/Faith".connect("pressed", func(): _select_founding_policy(Enum.PolicyType.Faith))
	
	
	
	#var deck = GameContent.GetStartingDeck(game.FoundingPolicy)
	#for i in range(game.GetMaxActivePolicies()):
		#game.ActivePolicies.append(deck.pop_front())
	pass

func _select_founding_policy(type : Enum.PolicyType):
	# Send choice to game object
	game.FoundingPolicy = type
	

	var foundingPolicyIcon = $"SocietyBar/FoundingPolicyIcon"
	foundingPolicyIcon.set_texture(game_manager.PolicyIcons[type])
	foundingPolicyIcon.modulate = game_manager.PolicyColors[type]
	
	# Set tooltip on icon
	var tooltip_text_map = {
		Enum.PolicyType.Undefined: "",
		Enum.PolicyType.War: "With 2+ active War effect:\nEvent magnitude reduced by 1.\n(Activated policies count)",
		Enum.PolicyType.Peace: "With 2+ active Peace policies:\n+1 active policy limit.",
		Enum.PolicyType.Science: "When Science policy expires:\nGain 1 reroll credit (max 1).",
		Enum.PolicyType.Faith: "Faith policies which can be activated\nwill grant ALL types.",
	}
	foundingPolicyIcon.tooltip_text = tooltip_text_map[game.FoundingPolicy]
	
	# can now reveal these areas
	SocietyBar.visible = true
	PolicyTrack.visible = true
	
	# Set active view for current state
	FoundingSocietyView.visible = false
	PolicyDraftView.visible = true
	
	RefreshUI()
	pass


func RefreshUI():
	if (game.State == Enum.GameState.Founding):
		pass
	
	RefreshUI_Policies()
	pass

func RefreshUI_Policies():
	var currentTiles = ActivePolicyArea.get_children()
	for i in range(currentTiles.size()):
		currentTiles[i].queue_free()
	
	var actives = game.ActivePolicies
	for i in range(actives.size()):
		var policy_node = ActivePolicyTemplate.instantiate()
		ActivePolicyArea.add_child(policy_node)
		policy_node.SetPolicyInfo(actives[i])
	pass

# ---------------------------------------------
