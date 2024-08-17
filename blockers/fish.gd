extends RigidBody2D

@export var init_speed = 5
var speed : float = init_speed
var direction
var velocity = Vector2.ZERO
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

func _ready():
	gravity_scale = 0
	
	direction = randi() % 2
	if direction == 0:
		direction = -1
		init_speed = 20
		sprite.flip_v = true
	
	velocity.x = direction * speed

func _physics_process(delta):
	if direction == 1:
		speed = init_speed - Global.addSpeed
	if direction == -1:
		speed = Global.addSpeed + init_speed
	velocity.x = direction * speed
	move_and_collide(velocity * delta)
