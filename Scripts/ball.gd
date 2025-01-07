extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	apply_central_impulse(Vector2(-414,212))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	pass # Replace with function body.
