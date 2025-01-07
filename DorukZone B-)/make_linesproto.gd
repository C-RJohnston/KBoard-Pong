extends RigidBody2D

@export var positions: Node2D
@onready var line = $Line2D
@onready var collision = $Collision
var default_color: Color = Color(1,1,1)

# Dictionary mapping input actions to positions
@onready var action_positions := {
	"Q": $"Positions/Q".position,
	"W": $"Positions/W".position,
	"E": $"Positions/E".position,
	"R": $"Positions/R".position,
	"T": $"Positions/E".position,
	"Y": $"Positions/E".position,
	"U": $"Positions/E".position,
	"E": $"Positions/E".position,
	"E": $"Positions/E".position,
	"E": $"Positions/E".position,

}

# Store active actions to draw lines
var active_actions := []

func _ready():
	pass

func _process(delta):
	pass
	
func _input(event):
	for action in action_positions.keys():
		if event.is_action_pressed(action) and action not in active_actions:
			active_actions.append(action)
		elif event.is_action_released(action) and action in active_actions:
			active_actions.erase(action)
	update_lines_with_collision()

func update_lines_with_collision():
	# Clear the Line2D points and previous collision shapes
	line.clear_points()
	#collision.polygon.clear()
	collision.polygon = [[0,0], [0,0]]
	
	if(active_actions.size() == 2):
		var start_pos = action_positions[active_actions[0]]
		var end_pos = action_positions[active_actions[1]]
		line.add_point(start_pos)
		line.add_point(end_pos)
		collision.polygon = [start_pos, end_pos]



func _on_body_entered(body):
	pass # Replace with function body.
