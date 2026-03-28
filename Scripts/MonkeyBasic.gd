extends Monkey

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@export var debugging: bool

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
	
	#Ray cast
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, player.global_position)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)

	if result.get("collider") is Player:
		see_player = true
	else:
		see_player = false
	
	
	if $Sprite2D.flip_h:
		$"Area2D-Left/CollisionPolygon2D".disabled = false
		$"Area2D-Right/CollisionPolygon2D".disabled = true
	
	else:
		$"Area2D-Left/CollisionPolygon2D".disabled = true
		$"Area2D-Right/CollisionPolygon2D".disabled = false
	
	if alerted:
		alert()
		
	var distance = global_position.distance_to(player.global_position)
	if alerted and distance < 26 and counter % 40 == 0:
		attack()
	elif not alerted:
		passive_movement()
	velocity.x = velocity.x
		
		
	counter += 1
	
	
func alert():
	if player.position.x < position.x:
		velocity.x = -run_speed
	else:
		velocity.x = run_speed
	set_collision_mask_value(4, false)


func _on_area_2d_right_body_entered(body):
	if see_player:
		print("Player right")
		alerted = true


func _on_area_2d_left_body_entered(body):
	if see_player:
		print("Player left")
		alerted = true
		

func _on_area_2d_agro_zone_body_exited(body):
	alerted = false
	print("Player out of zone")
	velocity.x = walk_speed
	markers_up()

func markers_up():
	set_collision_mask_value(4, true)
	
func passive_movement():
	if counter % 80 == 0 and velocity.x == 0:
		if debugging: print("SWAPPING")
		if int($Sprite2D.flip_h) == 0:
			velocity.x = -walk_speed
		else:
			velocity.x = walk_speed
	
	if counter % randi_range(50,150) == 0:
		if debugging: print("STOPPING")
		velocity.x = 0
		
	
func attack():
	player.hit(20)



