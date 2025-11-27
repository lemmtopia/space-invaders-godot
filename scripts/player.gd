extends Area2D

const VEL = 80
const PRE_PLAYER_PROJECTILE = preload("res://scenes/player_projectile.tscn")

const MAX_PLAYER_PROJECTILES = 1

const LENGTH = 7
const SCREEN_W = 180

const MIN_POS_X = LENGTH
const MAX_POS_X = SCREEN_W - LENGTH

var move = 0
var prev_fire = false

func _ready():
	# Called every time the node is added to the scene.
	set_process(true)

func _process(delta):
	# |erando meu dir no início desse frame.
	move = 0
	
	var left = Input.is_action_pressed("space_left")
	var right = Input.is_action_pressed("space_right")
	var fire = Input.is_action_pressed("space_fire")
	
	# Se nenhum,  move =  0.
	# Se right,   move =  1;
	# Se left,    move = -1;
	# Se os dois, move =  0.
	if right:
		move += 1
	
	if left:
		move -= 1
	
	# Pegando minha posição atual.
	var my_pos = get_global_pos()
	
	# Limitando a posição pegada.
	if my_pos.x < MIN_POS_X:
		my_pos.x = MIN_POS_X
	elif my_pos.x > MAX_POS_X:
		my_pos.x = MAX_POS_X
	
	# Aplicando as mudanças.
	set_global_pos(my_pos)
	
	translate(Vector2(1, 0) * VEL * move * delta)
	
	var projectiles = get_tree().get_nodes_in_group("player_projectile")
	if fire and not prev_fire and projectiles.size() < MAX_PLAYER_PROJECTILES:
		var projectile = PRE_PLAYER_PROJECTILE.instance()
		get_parent().add_child(projectile)
		projectile.set_global_pos(get_global_pos())
	
	prev_fire = fire

func destroy(caller_node):
	queue_free()