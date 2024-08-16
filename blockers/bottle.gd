extends RigidBody2D

@export var init_speed = 20
var speed : float = init_speed
var direction
var velocity = Vector2.ZERO
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

func _ready():
	gravity_scale = 0
	direction = -1
	speed = 20
	sprite.flip_v = true
	var flip = randi_range(0,1)
	if flip == 0:
		$Sprite2D.flip_h = true
	
	velocity.x = direction * speed

func _physics_process(delta):
	speed = Global.addSpeed + init_speed
	velocity.x = direction * speed
	move_and_collide(velocity * delta)
