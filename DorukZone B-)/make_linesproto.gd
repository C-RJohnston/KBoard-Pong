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
	"T": $"Positions/T".position,
	"Y": $"Positions/Y".position,
	"U": $"Positions/U".position,
	"I": $"Positions/I".position,
	"O": $"Positions/O".position,
	"P": $"Positions/P".position,
	"A": $"Positions/A".position,
	"S": $"Positions/S".position,
	"D": $"Positions/D".position,
	"F": $"Positions/F".position,
	"G": $"Positions/G".position,
	"H": $"Positions/H".position,
	"J": $"Positions/J".position,
	"K": $"Positions/K".position,
	"L": $"Positions/L".position,
	"Z": $"Positions/Z".position,
	"X": $"Positions/X".position,
	"C": $"Positions/C".position,
	"V": $"Positions/V".position,
	"B": $"Positions/B".position,
	"N": $"Positions/N".position,
	"M": $"Positions/M".position,
	"1": $"Positions/1".position,
	"2": $"Positions/2".position,
	"3": $"Positions/3".position,
	"4": $"Positions/4".position,
	"5": $"Positions/5".position,
	"6": $"Positions/6".position,
	"7": $"Positions/7".position,
	"8": $"Positions/8".position,
	"9": $"Positions/9".position,
	"0": $"Positions/0".position
	

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
