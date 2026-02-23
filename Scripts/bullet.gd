extends CharacterBody2D


@export var SPEED: int = 400
@export var damage: int = 20
var target_position

func _ready():
	pass



func _physics_process(delta):
	velocity = target_position * SPEED
	rotation = velocity.angle()
	var collision = move_and_collide(velocity * delta)
	
	
	if collision:
		var collider = collision.get_collider()
		if collider is Monkey:
			collider.hit(damage)
		elif collider is Player:
			collider.hit(damage)
		queue_free()
	
	


