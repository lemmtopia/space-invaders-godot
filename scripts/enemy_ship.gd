extends Area2D

var score = 200

signal destroyed(enemy)

func _ready():
	get_node("anim").play("default")
	yield(get_node("anim"), "finished")
	destroy(self)

func destroy(caller_node):
	emit_signal("destroyed", self)
	queue_free()