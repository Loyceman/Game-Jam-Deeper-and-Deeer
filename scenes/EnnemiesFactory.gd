extends Node2D

# Chemin vers la scène de l'obstacle et la caméra
var crocodile_scene = preload("res://ennemies/crocodile.tscn")
var camera


# Intervalle de temps entre chaque génération d'obstacle
@export var spawn_interval_crocodile_init = 15
var spawn_interval_crocodile : float = spawn_interval_crocodile_init
@onready var timerCroco : Timer = $TimerCroco

var zoom
var screen_size : Vector2i

func calculate_spawn_intervalle() :
	if spawn_interval_crocodile > 2.5 :
		spawn_interval_crocodile = spawn_interval_crocodile_init - Global.score/6000

func _ready():
	#relier les timer au fonction
	timerCroco.timeout.connect(spawn_crocodile)
	
	#Obtenir la cam
	camera = get_parent().get_node("Camera2D")
	
	#Obtient taille de l'écran
	screen_size = get_window().size
	
	#Obtient le zoom de la cam
	zoom = camera.get_zoom().x


func _process(_delta):
	timerCroco.set_wait_time(spawn_interval_crocodile)
		
	for child in get_children():
		if child.get_class() == "Timer" :
			continue
		if child.position.x + 40  < $"../Camera2D".position.x :
			child.queue_free()


func spawn_crocodile():
	# Instancier un nouvel obstacle
	var obstacle_instance : StaticBody2D = crocodile_scene.instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom + 16, camera.position.x + screen_size.x / zoom + 96)
	var random_y = randi_range(96, 200)
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)
