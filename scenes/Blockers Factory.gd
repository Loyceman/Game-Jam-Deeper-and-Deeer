extends Node2D

# Chemin vers la scène de l'obstacle et la caméra
var fish_scene = preload("res://blockers/fish.tscn")
var bottle_scene = preload("res://blockers/bottle.tscn")
var pipebas1_scene = preload("res://blockers/pipebas_L1_1.tscn")
var pipebas2_scene = preload("res://blockers/pipebas_L1_2.tscn")
var pipebas3_scene = preload("res://blockers/pipebas_L2_1.tscn")
var pipebas4_scene = preload("res://blockers/pipebas_L2_2.tscn")
var pipehaut1_scene = preload("res://blockers/pipehaut_L1.tscn")
var pipehaut2_scene = preload("res://blockers/pipehaut_L2.tscn")

var pipebas_scene = [pipebas1_scene, pipebas2_scene, pipebas3_scene, pipebas4_scene]
var pipehaut_scene = [pipehaut1_scene, pipehaut2_scene]
var pipes : int

var camera


# Intervalle de temps entre chaque génération d'obstacle
@export var spawn_interval_fish : float = 0.0
@export var spawn_interval_bottle : float = 0.0
@export var spawn_interval_pipebas : float = 0.0
@export var spawn_interval_pipehaut : float = 0.0

var timer1 : float = 0.0
var timer2 : float = 0.0
var timer3 : float = 0.0
var timer4 : float = 0.0

var zoom_x : int
var screen_size : Vector2i


func _ready():
	#Obtenir la caméra et son zoom
	camera = get_parent().get_node("Camera2D")
	zoom_x = camera.get_zoom().x

	#Obtient taille de l'écran
	screen_size = get_window().size
	
	# Initialiser les timers
	timer1 = spawn_interval_fish
	timer2 = spawn_interval_bottle
	timer3 = spawn_interval_pipebas
	timer4 = spawn_interval_pipehaut


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
	
	# Mettre à jour le timer3
	timer3 -= delta
	if timer3 <= 0:
		# Réinitialiser le timer
		timer3 = spawn_interval_pipebas
		# Générer un obstacle
		spawn_pipebas()
	
	# Mettre à jour le timer2
	timer4 -= delta
	if timer4 <= 0:
		# Réinitialiser le timer
		timer4 = spawn_interval_pipehaut
		# Générer un obstacle
		spawn_pipehaut()
	
	#Supprimer les éléments en dehors de la caméra
	for child in get_children():
		if(child.position.x + 20  < camera.position.x):
			child.queue_free()


func spawn_fish():
	# Instancier un nouvel obstacle
	var obstacle_instance = fish_scene.instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom_x + 16, camera.position.x + screen_size.x / zoom_x + 96)
	var random_y = randi_range(96, 208)
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)


func spawn_bottle():
	# Instancier un nouvel obstacle
	var obstacle_instance = bottle_scene.instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom_x + 16, camera.position.x + screen_size.x / zoom_x + 96)
	var random_y = randi_range(96, 208)
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)


func spawn_pipebas():
	# Instancier un nouvel obstacle
	pipes = randi() % 4
	var obstacle_instance = pipebas_scene[pipes].instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom_x + 16, camera.position.x + screen_size.x / zoom_x + 96)
	var random_y = 208
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)


func spawn_pipehaut():
	# Instancier un nouvel obstacle
	pipes = randi() % 2
	var obstacle_instance = pipehaut_scene[pipes].instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom_x + 16, camera.position.x + screen_size.x / zoom_x + 96)
	var random_y = 82
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)
