extends Character
class_name Monkey

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@export var debugging: bool
@export var attack_range: int = 26


signal on_alert
signal off_alert

var counter = 0
var run_speed = 50
var walk_speed = run_speed * 0.75
var alerted: bool = false





var see_player: bool = false
var last_position

# Called when the node enters the scene tree for the first time.
func _ready():
	super() # Replace with function body.
	velocity.x = walk_speed
	last_position = global_position



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super(delta)
	can_see_player()
	enable_disable_area2Ds()
	if alerted:
		chase_and_attack()
	else:
		passive_movement()
	counter += 1
	
func can_see_player():
	#Ray cast
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, player.global_position, 0x3) #0x3 specifies 0011 binary enabling layer masks 1 and 2 (ground & player).
	query.exclude = [self]
	var result = space_state.intersect_ray(query)

	if result.get("collider") is Player:
		see_player = true
	else:
		see_player = false

func enable_disable_area2Ds():
	if $Sprite2D.flip_h:
		$"Area2D-Left/CollisionPolygon2D".disabled = false
		$"Area2D-Right/CollisionPolygon2D".disabled = true
	
	else:
		$"Area2D-Left/CollisionPolygon2D".disabled = true
		$"Area2D-Right/CollisionPolygon2D".disabled = false

func chase_and_attack():
	#Jump if chasing player but blocked.
	if counter % 60 == 0 and is_on_wall():
		velocity.y = -randf_range(0.75, 1) * 250

	var distance = player.global_position.x - global_position.x
	
	#If within range, attack
	if abs(distance) < attack_range and counter % 40 == 0:
		attack()
	
	
	#Move to player, but stop a little bit out
	if distance > attack_range:
		velocity.x = run_speed
	elif distance < - attack_range:
		velocity.x = -run_speed
	else: velocity.x = 0


func _on_area_2d_right_body_entered(body):
	if see_player:
		emit_signal("on_alert")


func _on_area_2d_left_body_entered(body):
	if see_player:
		emit_signal("on_alert")
		

func _on_area_2d_agro_zone_body_exited(body):
	emit_signal("off_alert")
	velocity.x = walk_speed
	markers_up()

func markers_up():
	set_collision_mask_value(4, true)
	
func passive_movement():
	if counter % 80 == 0 and velocity.x == 0:
		#if debugging: print("SWAPPING")
		if int($Sprite2D.flip_h) == 0:
			velocity.x = -walk_speed
		else:
			velocity.x = walk_speed
	
	if counter % randi_range(50,150) == 0:
		velocity.x = 0
		
	
func attack():
	player.hit(20)
	
func die():
	queue_free()
	
func hit(damage):
	super(damage)
	emit_signal("on_alert")


func _when_on_alert() -> void:
	set_collision_mask_value(4, false)
	alerted = true


func _on_off_alert() -> void:
	set_collision_mask_value(4, true)
	alerted = false
	
