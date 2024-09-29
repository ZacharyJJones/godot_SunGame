extends Node

@export var animation_name : String
@export var delete_after_skip : bool

var _animation_player : AnimationPlayer
var can_skip : bool

func _ready():
	_animation_player = $".."
	_animation_player.current_animation_changed.connect(call_when_animation_changed)
	can_skip = animation_name == _animation_player.current_animation

func _process(_delta):
	if Input.is_anything_pressed() and can_skip and _animation_player.is_playing():
		_animation_player.seek(_animation_player.current_animation_length, true)
		if delete_after_skip:
			queue_free()

func call_when_animation_changed(changed_anim_name : String) -> void:
	can_skip = animation_name == changed_anim_name
