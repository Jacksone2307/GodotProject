extends Monkey

signal shoot_gun

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	super(delta)
	
func attack():
	emit_signal("shoot_gun")
	
