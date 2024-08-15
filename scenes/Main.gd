extends Node2D

@onready var background = $Background
@onready var camera = $Camera2D

var zoom_x : int
var speed : float
const START_SPEED : float = 0.5
const CAM_START_POS := Vector2i(0, 0)
var screen_size : Vector2i
var used_rect #jsp
var cell_size : Vector2i
var length_background : int



func _ready():

	#Obtient taille de l'écran et zoom de la camera
	screen_size = get_window().size
	zoom_x = camera.get_zoom().x
	
	# Obtient le nombre de tiles utilisés et leurs tailles. Calcul largeur TileMap
	used_rect = background.get_child(0).get_used_rect()
	cell_size = background.get_child(0).get_tileset().get_tile_size()
	length_background = used_rect.size.x * cell_size.x
	
	#Initialise les positions
	camera.position = CAM_START_POS
	background.position =  Vector2i(0,0)



func _process(_delta):
	#Vitesse de départ
	speed = START_SPEED
	
	#Move camera
	camera.position.x += speed
	
	#Si la caméra va plus loin que la taille de la TileMap, moins la taille de l'écran,
	#alors remet à jour la position de la caméra au début.
	if camera.position.x - background.position.x > (length_background - (screen_size.x / zoom_x + 3)):
		background.position.x = camera.position.x
