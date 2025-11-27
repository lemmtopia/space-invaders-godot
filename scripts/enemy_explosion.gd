extends Area2D

func _ready():
	get_node("anim").play("default")
	yield(get_node("anim"), "finished")
	queue_free()