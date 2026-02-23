class_name Character
extends CharacterBody2D


@export var health = 100
@export var health_bar: ProgressBar
@export var collider: CollisionShape2D

signal no_health

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	health_bar.value = health

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
	
func hit(damage):
	health -= damage
	health_bar.value = health
	if health <= 0:
		no_health.emit()


