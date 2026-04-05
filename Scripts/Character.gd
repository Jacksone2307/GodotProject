class_name Character
extends CharacterBody2D


@export var health = 100
@export var health_bar: ProgressBar
@export var collider: CollisionShape2D
@export var flipped: bool


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	health_bar.value = health
	$Sprite2D.flip_h = flipped

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	
	look_in_direction()
	move_and_slide()
	
func hit(damage):
	health -= damage
	health_bar.value = health
	if health <= 0:
		die()
		
func die():
	pass
	
func look_in_direction():
	if velocity.x:
		$Sprite2D.flip_h = velocity.x < 0
