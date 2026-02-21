extends CharacterBody2D


@export var SPEED: int = 400
var target_position

func _ready():
	pass



func _physics_process(delta):
	velocity = target_position * SPEED
	move_and_slide()
	rotation = velocity.angle()
	
	if(is_on_floor() or is_on_wall() or is_on_ceiling()):
		queue_free()
