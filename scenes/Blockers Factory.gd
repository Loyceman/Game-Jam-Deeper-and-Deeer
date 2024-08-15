extends Node2D

# Chemin vers la scène de l'obstacle et la caméra
var fish_scene = preload("res://blockers/fish.tscn")
var bottle_scene = preload("res://blockers/bottle.tscn")
var camera


# Intervalle de temps entre chaque génération d'obstacle
@export var spawn_interval_fish = 0.0
@export var spawn_interval_bottle = 0.0

var timer1 = 0.0
var timer2 = 0.0

var zoom
var screen_size : Vector2i


func _ready():
	#Obtenir la cam
	camera = get_parent().get_node("Camera2D")
	
	#Obtient taille de l'écran
	screen_size = get_window().size
	
	#Obtient le zoom de la cam
	zoom = camera.get_zoom().x
	
	# Initialiser le timer
	timer1 = spawn_interval_fish
	timer2 = spawn_interval_bottle


func _process(delta):
	# Mettre à jour le timer1
	timer1 -= delta
	if timer1 <= 0:
		# Réinitialiser le timer
		timer1 = spawn_interval_fish
		# Générer un obstacle
		spawn_fish()
	
		# Mettre à jour le timer2
	timer2 -= delta
	if timer2 <= 0:
		# Réinitialiser le timer
		timer2 = spawn_interval_bottle
		# Générer un obstacle
		spawn_bottle()


func spawn_fish():
	# Instancier un nouvel obstacle
	var obstacle_instance = fish_scene.instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom + 16, camera.position.x + screen_size.x / zoom + 96)
	var random_y = randi_range(96, 208)
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)


func spawn_bottle():
	# Instancier un nouvel obstacle
	var obstacle_instance = bottle_scene.instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom + 16, camera.position.x + screen_size.x / zoom + 96)
	var random_y = randi_range(96, 208)
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)
