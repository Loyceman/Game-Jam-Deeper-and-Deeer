extends RigidBody2D

@export var speed = 20
var flip
var velocity = Vector2.ZERO
@onready var sprite = $Sprite2D

func _ready():
	gravity_scale = 0
	
	flip = randi() % 2
	if flip == 0:
		sprite.flip_v = true
	
	velocity.x = 1 * speed

func _physics_process(delta):
	move_and_collide(velocity*delta)
