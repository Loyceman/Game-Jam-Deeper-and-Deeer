extends Node2D

# Chemin vers la scène de l'obstacle et la caméra
var fish_scene = preload("res://blockers/fish.tscn")
var bottle_scene = preload("res://blockers/bottle.tscn")
var camera


# Intervalle de temps entre chaque génération d'obstacle
@export var spawn_interval_fish_init : float = 4
@export var spawn_interval_bottle_init : float = 4

var spawn_interval_fish : float = spawn_interval_fish_init
var spawn_interval_bottle : float = spawn_interval_bottle_init

var timer1 = 0.0
var timer2 = 0.0

var zoom
var screen_size : Vector2i

func calculate_spawn_intervalle(score : int) :
	if spawn_interval_fish>1 and spawn_interval_bottle>1:
		spawn_interval_fish = spawn_interval_fish_init - score/1000
		spawn_interval_bottle = spawn_interval_bottle_init - score/1000

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
		
	for child in get_children():
		if(child.position.x + 20  < $"../Camera2D".position.x):
			child.queue_free()


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
