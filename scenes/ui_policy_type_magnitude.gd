extends Panel

@export var images : Array[CompressedTexture2D]
@export var colors : Array[Color]

func SetLabel(value):
	$"Vbox/Label".text = str(value)
	
func Initialize(type : Enum.PolicyType):
	$"Vbox/Icon".set_texture(images[type])
	$"Vbox".modulate = colors[type]
