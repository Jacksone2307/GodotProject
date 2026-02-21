extends CharacterBody2D


@export var SPEED: int = 400
var target_position

func _ready():
	pass



func _physics_process(delta):
	velocity = target_position * SPEED
	rotation = velocity.angle()
	var collision = move_and_collide(velocity * delta)
	
	
	if collision:
		var collider = collision.get_collider()
		queue_free()
	
	

func _hit_character():
	pass
