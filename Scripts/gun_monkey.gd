extends Gun
class_name monkey_gun


@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var monkey_marker_2d : Marker2D = $Marker2D

var on_alert = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
	if on_alert:
		look_at(player.global_position)
		face_up()
	else: 
		rotation = 0
		flip_v = false


func _on_monkey_basic_shoot_gun() -> void:
	var monkey_bullet = bullet_scene.instantiate()
	monkey_bullet.position = monkey_marker_2d.global_position
	var target_position = 	(player.global_position - monkey_marker_2d.global_position).normalized().rotated(pi/20 * randf())
	monkey_bullet.target_position = target_position
	get_tree().get_root().add_child(monkey_bullet)


func _on_monkey_basic_on_alert() -> void:
	on_alert = true


func _on_monkey_basic_off_alert() -> void:
	on_alert = false
