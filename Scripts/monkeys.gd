extends Character
class_name Monkey


var alerted: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	super() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super(delta)
	
func _alert():
	pass

func die():
	queue_free()
	
func hit(damage):
	super(damage)
	alerted = true
