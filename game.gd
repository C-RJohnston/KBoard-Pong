extends Node2D

@export var MAX_LINES = 2

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
var active_actions: Array

# Store active lines
var lines: Array

func _input(event):
	for action in action_positions.keys():
		if event.is_action_pressed(action) and action not in active_actions:
			add_point(action)
		elif event.is_action_released(action) and action in active_actions:
			remove_point(action)
			

func add_point(action: String):
	active_actions.append(action)
	if active_actions.size() % 2 == 0 and lines.size() < MAX_LINES:
		var start_pos = action_positions[active_actions[-1]]
		var end_pos = action_positions[active_actions[-2]]
		
		var line = Line.new_line(start_pos, end_pos,[active_actions[-1], active_actions[-2]])
		add_child(line)
		line.collided.connect(sounds_play_sound)
		lines.append(line)

func sounds_play_sound(keys: Array):
	$Sounds.play_chords(keys)

func remove_point(action: String):
	active_actions.erase(action)
	var action_position = action_positions[action]
	for line in lines:
		var ix = line.get_points().find(action_position)
		if ix != -1:
			var i = lines.find(line)
			lines.erase(line)
			line.queue_free()
