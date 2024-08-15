extends Node2D

# Chemin vers la scène de l'obstacle et la caméra
var obstacle_scene = preload("res://blockers/fish.tscn")
var camera


# Intervalle de temps entre chaque génération d'obstacle
var spawn_interval = 1.0
var timer = 0.0

var zoom
var screen_size : Vector2i
var spawn_area_width = 300
var spawn_area_height = 300


func _ready():
	#Obtenir la cam
	camera = get_parent().get_node("Camera2D")
	
	#Obtient taille de l'écran
	screen_size = get_window().size
	
	#Obtient le zoom de la cam
	zoom = camera.get_zoom().x
	
	# Initialiser le timer
	timer = spawn_interval


func _process(delta):
	# Mettre à jour le timer
	timer -= delta
	if timer <= 0:
		# Réinitialiser le timer
		timer = spawn_interval
		
		# Générer un obstacle
		spawn_obstacle()

func spawn_obstacle():
	# Instancier un nouvel obstacle
	var obstacle_instance = obstacle_scene.instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom + 16, camera.position.x + screen_size.x / zoom + 96)
	var random_y = randi_range(96, 208)
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)
