extends RigidBody2D

# Speeds of the ball
@export var MAX_SPEED = 4000
@export var MIN_SPEED = 100
@export var DEFAULT_SPEED = 400
# Maximum number of points in the trail
@export var max_points: int = 50
@onready var initial_position = position
@onready var line = $LineEffect
var queue: Array
# Called when the node enters the scene tree for the first time.
func _ready():
	# Random velocity, should change to variable later
	set_axis_velocity(Vector2(DEFAULT_SPEED,0))
	line.clear_points()
	queue.clear()

func set_speed(amount: float):
	var speed = linear_velocity.length()
	var unit = linear_velocity / speed
	var new_speed = clamp(amount, MIN_SPEED, MAX_SPEED)
	set_axis_velocity(unit * new_speed)

func increase_speed(amount: float):
	var speed = linear_velocity.length()
	var unit = linear_velocity / speed
	var new_speed = min(MAX_SPEED, speed + amount)
	set_axis_velocity(unit * new_speed)

func decrease_speed(amount: float):
	var speed = linear_velocity.length()
	var unit = linear_velocity / speed
	var new_speed = max(MIN_SPEED, speed - amount)
	set_axis_velocity(unit * new_speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue.push_front(position)
	if queue.size() > max_points:
		queue.pop_back()
	line.clear_points()
	for point in queue:
		line.add_point(point)

func _on_body_entered(body):
	if body.is_in_group("wall"):
		#AudioStreamPlayer.play()
		pass
