extends Node

var score = 0

func _ready():
	update_score_label()
	get_node("enemy_group").connect("enemy_destroyed", self, "on_enemy_group_enemy_destroyed")

func on_enemy_group_enemy_destroyed(enemy):
	score += enemy.score
	update_score_label()

func update_score_label():
	get_node("interface/score").set_text(str(score))