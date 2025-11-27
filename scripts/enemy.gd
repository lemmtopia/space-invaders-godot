tool
extends Area2D

export(int, "A", "B", "C") var type = 0 setget set_type

var score = 0
var frame = 0

signal destroyed(inst)

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
	pass

func _draw():
	get_node("sprite").set_texture(attribute_array[type].texture)
	score = attribute_array[type].score

func set_type(value):
	type = value
	
	if is_inside_tree() and get_tree().is_editor_hint():
		update()

func destroy(caller_node):
	emit_signal("destroyed", self)
	queue_free()

func next_frame():
	if frame == 0:
		frame = 1
	else:
		frame = 0
	
	get_node("sprite").set_frame(frame)