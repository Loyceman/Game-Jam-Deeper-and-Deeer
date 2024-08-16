extends Node2D

# Chemin vers la scène de l'obstacle et la caméra
var crocodile_scene = preload("res://ennemies/crocodile.tscn")
var camera


# Intervalle de temps entre chaque génération d'obstacle
@export var spawn_interval_crocodile_init = 4
var spawn_interval_crocodile : float = spawn_interval_crocodile_init

var timer1 = 0.0

var zoom
var screen_size : Vector2i

func calculate_spawn_intervalle(score : int) :
	if spawn_interval_crocodile > 2 :
		spawn_interval_crocodile = spawn_interval_crocodile_init - score/4000

func _ready():
	#Obtenir la cam
	camera = get_parent().get_node("Camera2D")
	
	#Obtient taille de l'écran
	screen_size = get_window().size
	
	#Obtient le zoom de la cam
	zoom = camera.get_zoom().x
	
	# Initialiser le timer
	timer1 = spawn_interval_crocodile


func _process(delta):
	# Mettre à jour le timer1
	timer1 -= delta
	if timer1 <= 0:
		# Réinitialiser le timer
		timer1 = spawn_interval_crocodile
		# Générer un obstacle
		spawn_crocodile()
		
	for child in get_children():
		if(child.position.x + 40  < $"../Camera2D".position.x):
			child.queue_free()


func spawn_crocodile():
	# Instancier un nouvel obstacle
	var obstacle_instance : StaticBody2D = crocodile_scene.instantiate()
	
	obstacle_instance.set_rotation_degrees(180)
	
	var direction = randi_range(0,1)
	if(direction == 0):
		obstacle_instance.scale.y = -obstacle_instance.scale.y
	elif (direction == 1):
		obstacle_instance.scale.y = obstacle_instance.scale.y
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom + 16, camera.position.x + screen_size.x / zoom + 96)
	var random_y = randi_range(84, 208)
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)
