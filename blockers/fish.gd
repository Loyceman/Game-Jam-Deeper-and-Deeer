extends RigidBody2D

@export var speed = 50
var direction
var velocity = Vector2.ZERO
@onready var sprite = $Sprite2D

func _ready():
	gravity_scale = 0
	
	direction = randi() % 2
	if direction == 0:
		direction = -1
		speed = 20
		sprite.flip_v = true
	velocity.x = direction * speed

func _physics_process(delta):
	move_and_collide(velocity*delta)
