extends Node

var score = 0

func _ready():
	randomize()
	
	update_score_label()
	get_node("enemy_group").connect("enemy_destroyed", self, "on_enemy_group_enemy_destroyed")
	get_node("player").connect("destroyed", self, "on_player_destroyed")
	get_node("player").connect("respawned", self, "on_player_respawned")

func on_enemy_group_enemy_destroyed(enemy):
	score += enemy.score
	update_score_label()

func update_score_label():
	get_node("interface/score").set_text(str(score))

func on_player_destroyed():
	get_node("enemy_group").stop_all()

func on_player_respawned():
	get_node("enemy_group").start_all()