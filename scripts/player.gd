extends Area2D

const VEL = 100

var move = 0

func _ready():
	# Called every time the node is added to the scene.
	set_process(true)
	pass

func _process(delta):
	# zerando meu dir no início desse frame
	move = 0
	
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	
	# se nenhum, move = 0 
	# se right, move = 1
	# se left, move = -1
	# se os dois, move = 1 - 1 = 0
	if right:
		move += 1
	
	if left:
		move -= 1
	
	translate(Vector2(1, 0) * VEL * move * delta)