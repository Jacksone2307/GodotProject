extends Node2D

@export var player_scene: PackedScene


var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = player_scene.instantiate()
	add_child(player)


func _input(event):
	if event.is_action_pressed("Keyboard_R"):
		player.queue_free()
		player = player_scene.instantiate()
		add_child(player)

