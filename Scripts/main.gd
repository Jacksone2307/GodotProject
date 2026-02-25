extends Node2D

@export var player_scene: PackedScene
@export var monkey_basic_scene: PackedScene
@onready var player = $Player
@onready var monkey_basic = $monkey_basic

#var player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _input(event):
	if event.is_action_pressed("Keyboard_R"):
		player.position = Vector2(0,0)
