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
	
	var direction = Input.get_axis("Left", "Right")
	if direction:
		position.x = direction*abs(position.x)
		flip_v = direction < 0
		marker_2d.position.y 

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = marker_2d.global_position
	var target_position = (get_global_mouse_position() - marker_2d.global_position).normalized().rotated(pi/20 * randf())
	bullet.target_position = target_position
	
	#bullet.look_at(get_global_mouse_position())
	get_tree().get_root().add_child(bullet)


	
