extends RigidBody2D

# Maximum number of points in the trail
@export var max_points: int = 50
@onready var initial_position = position
@onready var line = $LineEffect
var queue: Array
# Called when the node enters the scene tree for the first time.
func _ready():
	# Random velocity, should change to variable later
	apply_central_impulse(Vector2(400,0))
	line.clear_points()
	queue.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue.push_front(position)
	if queue.size() > max_points:
		queue.pop_back()
	line.clear_points()
	for point in queue:
		line.add_point(point)



func _on_body_entered(body):
	pass # Replace with function body.
