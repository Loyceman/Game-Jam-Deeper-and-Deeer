extends Node2D

# Chemin vers la scène de l'obstacle et la caméra
var bridge_scene = preload("res://background/bridge.tscn")
var camera


# Intervalle de temps entre chaque génération d'obstacle
@export var spawn_interval_bridge_init = 50
var spawn_interval_bridge : float = spawn_interval_bridge_init

var timer1 = 0.0

var zoom
var screen_size : Vector2i

func calculate_spawn_intervalle(score : int) :
	if spawn_interval_bridge > 3 :
		spawn_interval_bridge = spawn_interval_bridge_init - score/1000

func _ready():
	#Obtenir la cam
	camera = get_parent().get_node("Camera2D")
	
	#Obtient taille de l'écran
	screen_size = get_window().size
	
	#Obtient le zoom de la cam
	zoom = camera.get_zoom().x
	
	# Initialiser le timer
	timer1 = spawn_interval_bridge


func _process(delta):
	# Mettre à jour le timer1
	timer1 -= delta
	if timer1 <= 0:
		# Réinitialiser le timer
		timer1 = spawn_interval_bridge
		# Générer un obstacle
		spawn_bridge()
		
	for child in get_children():
		if(child.position.x + 100  < camera.position.x):
			child.queue_free()


func spawn_bridge():
	# Instancier un nouvel obstacle
	var obstacle_instance = bridge_scene.instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom + 16, camera.position.x + screen_size.x / zoom + 96)
	var random_y = 208
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)
