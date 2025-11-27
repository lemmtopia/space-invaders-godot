extends Area2D

const MAX_HITS = 6

var hits = 0

func destroy(caller_node):
	hits += 1
	get_node("sprite").set_frame(hits)
	
	if hits + 1 >= MAX_HITS: 
		queue_free()