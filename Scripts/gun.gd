extends Sprite2D

@export var bullet_scene: PackedScene
@onready var marker_2d : Marker2D = $Marker2D
const pi = 3.14159



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	face_up()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = marker_2d.global_position
	var target_position = (get_global_mouse_position() - marker_2d.global_position).normalized().rotated(pi/20 * randf())
	bullet.target_position = target_position
	
	#bullet.look_at(get_global_mouse_position())
	get_tree().get_root().add_child(bullet)


	
func face_up():
	#Make gun always face up.
	if (0.5 * pi) < fmod(abs(rotation), 2*pi) and fmod(abs(rotation), 2*pi) < (1.5 * pi):
		flip_v = 1
	else:
		flip_v = 0

func _on_player_has_flipped() -> void:
	position.x = -position.x
	marker_2d.position.y 
