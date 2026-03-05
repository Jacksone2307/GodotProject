extends Monkey

@onready var player : Player = get_tree().get_first_node_in_group("Player")


var alerted: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	super() # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super(delta)
	
	if $Sprite2D.flip_h:
		$"Area2D-Left/CollisionPolygon2D".disabled = false
		$"Area2D-Right/CollisionPolygon2D".disabled = true
	
	else:
		$"Area2D-Left/CollisionPolygon2D".disabled = true
		$"Area2D-Right/CollisionPolygon2D".disabled = false
	
	if alerted:
		alert()
	
	
func alert():
	if player.position.x < position.x:
		velocity.x = -50
	else:
		velocity.x = 50


func _on_area_2d_right_body_entered(body):
	print("Player right")
	alerted = true


func _on_area_2d_left_body_entered(body):
	print("Player left")
	alerted = true
	
func absent_minded_movement():
	pass 
	#Path following???
