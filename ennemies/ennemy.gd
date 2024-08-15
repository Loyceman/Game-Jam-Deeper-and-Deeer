extends StaticBody2D

class_name Ennemy

@export var speed = 15
var velocity : Vector2 = Vector2(-speed,0)

func isEnnemy():
	return true

func _physics_process(delta):
	move_and_collide(velocity*delta)

func died():
	queue_free()
