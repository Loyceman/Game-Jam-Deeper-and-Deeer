extends Node2D

var menu_scene = preload("res://scenes/menu_scene.tscn")
var main_scene = preload("res://scenes/main.tscn")

# Appelée lorsque le nœud entre dans l'arbre de la scène
func _ready():
	# Charge la scène du menu au démarrage
	_load_scene(menu_scene)

# Fonction pour charger une nouvelle scène
func _load_scene(scene: PackedScene):
	# Efface les enfants existants de la scène actuelle
	for child in get_children():
		child.queue_free()
	# Instancie la nouvelle scène et l'ajoute comme enfant
	var instance = scene.instantiate()
	add_child(instance)

	# Connecte le signal pour gérer le clic sur "Play" si c'est la scène du menu
	if scene == menu_scene:
		var play_button : Button = instance.get_node("Control").get_node("ButtonPlay")
		if(play_button != null) :
			play_button.pressed.connect(_on_play_button_pressed)

# Fonction appelée lorsqu'on clique sur le bouton "Play"
func _on_play_button_pressed():
	# Change la scène en celle du jeu
	_load_scene(main_scene)
