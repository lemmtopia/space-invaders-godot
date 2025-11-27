extends Area2D

export(int, "A", "B", "C") var type = 0

var score = 0

var attribute_array = [
	{
		texture = preload("res://sprites/InvaderA_sheet.png"),
		score = 10
	},
	{
		texture = preload("res://sprites/InvaderB_sheet.png"),
		score = 20
	},
	{
		texture = preload("res://sprites/InvaderC_sheet.png"),
		score = 50
	}
]

func _ready():
	get_node("sprite").set_texture(attribute_array[type].texture)
	score = attribute_array[type].score
