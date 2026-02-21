extends CharacterBody2D


const SPEED = 200
const JUMP_VELOCITY = -250

const MAX_NUM_JUMPS = 2
var num_jumps = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		num_jumps = MAX_NUM_JUMPS

	# Handle jump.
	if Input.is_action_just_pressed("Up") and ( is_on_floor() or is_on_wall() or num_jumps > 0) :
		velocity.y = JUMP_VELOCITY
		num_jumps -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x:
		$Sprite2D.flip_h = velocity.x < 0

	move_and_slide()

func _input(event):
	if event.is_action_pressed("Mouse_Left"):
		$Gun.shoot()
		velocity += 0.5*abs(JUMP_VELOCITY)*(global_position - get_global_mouse_position()).normalized()


