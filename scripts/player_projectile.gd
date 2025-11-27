extends Area2D

const VEL = 250

var move = Vector2(0, -1)

func _ready():
	set_process(true)

func _process(delta):
	translate(move * VEL * delta)