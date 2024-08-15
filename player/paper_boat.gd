class_name Player 

extends CharacterBody2D

@export var speed = 35

signal game_over()

func isPlayer(): 
	return true

func _ready():
	$".".get_viewport_rect()
	$HitBox.body_entered.connect(hit)

func get_input():
	var input_direction_y = Input.get_axis("move_up", "move_down")
	var input_direction_x = Input.get_action_strength("move_right")
	velocity.y = input_direction_y * speed
	velocity.x = input_direction_x * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
	
	if($"Sprites Boat".get_frame()==3):
		died()
	
func died():
	$"Sprites Boat".play()
	await $"Sprites Boat".animation_finished
	queue_free()
	emit_signal("game_over")


func hit(body : Node2D):
	if (body.has_method("isEnnemy")):
		lose_health()
	
func lose_health():
	$"Sprites Boat".set_frame($"Sprites Boat".get_frame()+1)
