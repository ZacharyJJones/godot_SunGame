extends Panel

@export var images : Array[CompressedTexture2D]
@export var colors : Array[Color]

func SetQuantity(quantity : int):
	$"Vbox/Quantity".text = str(quantity)

func Initialize(type : Enum.PolicyType):
	$"Vbox/Icon".set_texture(images[type])
	$"Vbox".modulate = colors[type]
