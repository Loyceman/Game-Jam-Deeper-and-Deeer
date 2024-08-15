extends Node2D

@onready var background = $Background
@onready var camera = $Camera2D
@onready var scorelabel : Label = $Camera2D/Control/ScoreLabel

var zoom_x : int 
var speed : float
const START_SPEED : float = 0.5
const CAM_START_POS := Vector2i(0, 0)
var screen_size : Vector2i
var used_rect
var cell_size
var length_background

var score : float = 0 


# Called when tgame()he node enters the scene tree for the first time.
func _ready():
	#Obtient taille de l'écran
	screen_size = get_window().size
	
	#Obtient le zoom de la cam
	zoom_x = camera.get_zoom().x
	
	# Obtient le rectangle utilisé par le TileMap
	used_rect = background.get_child(0).get_used_rect()

	# La taille d'une cellule (Vector2)
	cell_size = background.get_child(0).get_tileset().get_tile_size()

	# Calculer la largeur en pixels
	length_background = used_rect.size.x * cell_size.x
	
	new_game()

func new_game():
	camera.position = CAM_START_POS
	background.position =  Vector2i(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = START_SPEED
	
	#Move camera
	camera.position.x += speed
	
	if camera.position.x - background.position.x > (length_background - (screen_size.x / zoom_x + 3)): # le +3 permet de realiser une transi plus clean 
		background.position.x = camera.position.x
		
	increase_score(100*delta)

# Fonction pour mettre à jour l'affichage du score
func _update_score():
	if scorelabel:
		scorelabel.set_text("Score: %d" % score)

# Exemple d'une fonction pour augmenter le score
func increase_score(points: int):
	score += points
	$"Blockers Factory".calculate_spawn_intervalle(score)
	_update_score()
