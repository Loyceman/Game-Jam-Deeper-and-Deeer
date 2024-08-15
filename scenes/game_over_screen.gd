extends Node2D

@export var timeToWait : int = 3 # in seconds 


signal game_over_finished()

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(timeToWait).timeout
	emit_signal("game_over_finished")
