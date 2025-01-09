extends Node2D

@export var MAX_LINES = 2
var wiggle_timer = 0.0
@export var wiggle_speed = 10.0  # Speed of the wiggle
@export var wiggle_amount = 0.1  # Amount of the wiggle (rotation in radians)

var ball_scene = load("res://Scenes/Ball/ball.tscn")

# Dictionary mapping input actions to positions
@onready var action_positions := {
	"Q": $"Positions/Q",
	"W": $"Positions/W",
	"E": $"Positions/E",
	"R": $"Positions/R",
	"T": $"Positions/T",
	"Y": $"Positions/Y",
	"U": $"Positions/U",
	"I": $"Positions/I",
	"O": $"Positions/O",
	"P": $"Positions/P",
	"A": $"Positions/A",
	"S": $"Positions/S",
	"D": $"Positions/D",
	"F": $"Positions/F",
	"G": $"Positions/G",
	"H": $"Positions/H",
	"J": $"Positions/J",
	"K": $"Positions/K",
	"L": $"Positions/L",
	"Z": $"Positions/Z",
	"X": $"Positions/X",
	"C": $"Positions/C",
	"V": $"Positions/V",
	"B": $"Positions/B",
	"N": $"Positions/N",
	"M": $"Positions/M",
	"1": $"Positions/1",
	"2": $"Positions/2",
	"3": $"Positions/3",
	"4": $"Positions/4",
	"5": $"Positions/5",
	"6": $"Positions/6",
	"7": $"Positions/7",
	"8": $"Positions/8",
	"9": $"Positions/9",
	"0": $"Positions/0"
}

# Store active actions to draw lines
var active_actions: Array

# Store active lines
var lines: Array

var _delta : float

func _ready():
	pass

func _physics_process(delta: float) -> void:
	_delta = delta
	for action in active_actions:
		wiggle_timer += _delta * wiggle_speed
		action_positions[action].rotation = sin(wiggle_timer) * wiggle_amount
		

func _input(event):
	for action in action_positions.keys():
		if event.is_action_pressed(action) and action not in active_actions:
			add_point(action)
			
		elif event.is_action_released(action) and action in active_actions:
			remove_point(action)
			

func add_point(action: String):
	active_actions.append(action)
	if active_actions.size() % 2 == 0 and lines.size() < MAX_LINES:
		var start_pos = action_positions[active_actions[-1]].position
		var end_pos = action_positions[active_actions[-2]].position
		
		var line = Line.new_line(start_pos, end_pos,[active_actions[-1], active_actions[-2]])
		add_child(line)
		line.collided.connect(sounds_play_sound)
		lines.append(line)

func sounds_play_sound(keys: Array):
	$Sounds.play_chords(keys)

func remove_point(action: String):
	active_actions.erase(action)
	var action_position = action_positions[action].position
	for line in lines:
		var ix = line.get_points().find(action_position)
		if ix != -1:
			var i = lines.find(line)
			lines.erase(line)
			line.queue_free()


func _on_ball_minus_pressed() -> void:
	var nodes_in_group = get_tree().get_nodes_in_group('Ball')
	# Check if there are nodes in the group
	if nodes_in_group.size() > 1:
		# Get the last node in the group
		var last_node = nodes_in_group[nodes_in_group.size() - 1]
		if last_node.is_inside_tree():
			last_node.queue_free()


func _on_ball_plus_pressed() -> void:
	var new_ball = ball_scene.instantiate()
	var viewport_size = get_viewport_rect().size
	var random_x = randf_range(0, viewport_size.x)
	var random_y = randf_range(0, viewport_size.y)
	var ball_position = Vector2(random_x, random_y)
	new_ball.position = ball_position
	add_child(new_ball)

func _on_exit_button_pressed() -> void:
	$PanelContainer.visible = false
