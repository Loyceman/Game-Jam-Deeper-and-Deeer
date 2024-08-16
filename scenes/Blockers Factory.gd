extends Node2D

# Chemin vers la scène de l'obstacle et la caméra
var fish_scene = preload("res://blockers/fish.tscn")
var bottle_scene = preload("res://blockers/bottle.tscn")
var pipebas1_scene = preload("res://blockers/pipebas_L1_1.tscn")
var pipebas2_scene = preload("res://blockers/pipebas_L1_2.tscn")
var pipebas3_scene = preload("res://blockers/pipebas_L2_1.tscn")
var pipebas4_scene = preload("res://blockers/pipebas_L2_2.tscn")

var pipebas_scene = [pipebas1_scene, pipebas2_scene, pipebas3_scene, pipebas4_scene]
var pipes : int

var camera


# Intervalle de temps entre chaque génération d'obstacle
@export var spawn_interval_fish_init : float = 4
@export var spawn_interval_bottle_init : float = 4
@export var spawn_interval_pipebas_init : float = 10

var spawn_interval_fish : float = spawn_interval_fish_init
var spawn_interval_bottle : float = spawn_interval_bottle_init
var spawn_interval_pipebas : float = spawn_interval_pipebas_init

@onready var timerFish : Timer = $TimerFish
@onready var timerBottle : Timer = $TimerBottle
@onready var timerPipe : Timer = $TimerPipe

var zoom_x : int
var screen_size : Vector2i

func calculate_spawn_intervalle() :
	if (spawn_interval_fish - Global.score/10000) >0.5 and (spawn_interval_bottle - Global.score/10000) >0.5 and (spawn_interval_pipebas - Global.score/15000)>2:
		spawn_interval_fish = spawn_interval_fish_init - Global.score/10000
		spawn_interval_bottle = spawn_interval_bottle_init - Global.score/10000
		spawn_interval_pipebas = spawn_interval_pipebas_init - Global.score/15000


func _ready():
	#relier le timer 
	timerBottle.timeout.connect(spawn_bottle)
	timerFish.timeout.connect(spawn_fish)
	timerPipe.timeout.connect(spawn_pipebas)
	
	#Obtenir la caméra et son zoom
	camera = get_parent().get_node("Camera2D")
	zoom_x = camera.get_zoom().x

	#Obtient taille de l'écran
	screen_size = get_window().size


func _process(_delta):
	timerBottle.set_wait_time(spawn_interval_bottle)
	timerFish.set_wait_time(spawn_interval_fish)
	timerPipe.set_wait_time(spawn_interval_pipebas)
	
	#Supprimer les éléments en dehors de la caméra
	for child in get_children():
		if child.get_class() == "Timer" :
			continue
		if(child.position.x + 20  < camera.position.x):
			child.queue_free()

func random_position():
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom_x + 16, camera.position.x + screen_size.x / zoom_x + 96)
	var random_y = randi_range(84, 208)
	return Vector2(random_x, random_y)

func spawn_fish():
	var obstacle_instance = fish_scene.instantiate()
	
	obstacle_instance.position = random_position()
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)


func spawn_bottle():
	var obstacle_instance = bottle_scene.instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	obstacle_instance.position = random_position()
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)


func spawn_pipebas():
	pipes = randi() % 4
	var obstacle_instance = pipebas_scene[pipes].instantiate()
	
	# Définir une position aléatoire pour l'obstacle
	var random_x = randi_range(camera.position.x + screen_size.x / zoom_x + 16, camera.position.x + screen_size.x / zoom_x + 96)
	var random_y = 208
	obstacle_instance.position = Vector2(random_x, random_y)
	
	# Ajouter l'obstacle à la scène
	add_child(obstacle_instance)
