extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):

	if (body.has_method("isPlayer")): 
		$"../../Paper Boat".died()
