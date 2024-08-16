extends Node2D

@onready var background = $Background
@onready var camera = $Camera2D
@onready var scorelabel : Label = $Camera2D/Control/ScoreLabel
@onready var timer : Timer = $TimerPoint

var zoom_x : int 
var speed : float
const START_SPEED : float = 0.5
const CAM_START_POS : Vector2i = Vector2i(0, 0)
var screen_size : Vector2i
var used_rect #jsp
var cell_size : Vector2i
var length_background : int

var score : float = 0 
const pointsEveryTimeout : int = 10

signal change_to_game_over(score: int)

func _ready():
	timer.start()
	timer.timeout.connect(increase_score)
	$"Paper Boat".game_over.connect(call_scene_manager_for_game_over)
	
	#Obtient taille de l'écran et zoom de la camera
	screen_size = get_window().size
	zoom_x = camera.get_zoom().x
	
	#Obtient le zoom de la cam
	zoom_x = camera.get_zoom().x
	
	# Obtient le rectangle utilisé par le TileMap
	# Obtient le nombre de tiles utilisés et leurs tailles. Calcul largeur TileMap
	used_rect = background.get_child(0).get_used_rect()
	cell_size = background.get_child(0).get_tileset().get_tile_size()
	length_background = used_rect.size.x * cell_size.x
	
	new_game()

func new_game():
	camera.position = CAM_START_POS
	background.position =  Vector2i(0,0)


func _process(delta):
	#Vitesse de départ
	speed = START_SPEED
	
	#Move camera
	camera.position.x += speed 
	
	#Si la caméra va plus loin que la taille de la TileMap, moins la taille de l'écran,
	#alors remet à jour la position de la caméra au début.
	if camera.position.x - background.position.x > (length_background - (screen_size.x / zoom_x - 14)):
		background.position.x = camera.position.x

# Fonction pour mettre à jour l'affichage du score
func _update_score():
	if scorelabel:
		scorelabel.set_text("Score: %d" % score)

# Exemple d'une fonction pour augmenter le score
func increase_score():
	score += pointsEveryTimeout
	$"Blockers Factory".calculate_spawn_intervalle(score)
	$EnnemiesFactory.calculate_spawn_intervalle(score)
	_update_score()
	
func call_scene_manager_for_game_over():
	emit_signal("change_to_game_over", score)
