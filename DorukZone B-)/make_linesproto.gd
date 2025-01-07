extends Node2D

# Dictionary mapping input actions to positions
var action_positions := {
	"Q": Vector2(100, 100),
	"W": Vector2(100, 300),
	"E": Vector2(300, 300),
	"R": Vector2(300, 100)
}

# Store active actions to draw lines
var active_actions := []

# Line2D node for drawing lines
var line_node: Line2D

# Collision shapes for the lines
var collision_shapes := []

func _ready():
	# Create and set up a Line2D node
	line_node = Line2D.new()
	line_node.default_color = Color(1, 1, 1)
	add_child(line_node)

func _process(delta):
	# Check each action in the Input Map
	for action in action_positions.keys():
		if Input.is_action_pressed(action) and action not in active_actions:
			active_actions.append(action)
			update_lines_with_collision()
		elif not Input.is_action_pressed(action) and action in active_actions:
			active_actions.erase(action)
			update_lines_with_collision()

func update_lines_with_collision():
	# Clear the Line2D points and previous collision shapes
	line_node.clear_points()
	for shape in collision_shapes:
		shape.queue_free()
	collision_shapes.clear()

	# Add points to the Line2D node and create collision shapes
	for i in range(active_actions.size() - 1):
		var start_pos = action_positions[active_actions[i]]
		var end_pos = action_positions[active_actions[i + 1]]
		line_node.add_point(start_pos)
		line_node.add_point(end_pos)
		
		# Create and configure CollisionPolygon2D for the line
		var collision_polygon = CollisionPolygon2D.new()
		var thickness = 10.0
		collision_polygon.polygon = create_collision_polygon(start_pos, end_pos, thickness)
		collision_polygon.position = (start_pos + end_pos) / 2
		add_child(collision_polygon)
		collision_shapes.append(collision_polygon)

func create_collision_polygon(p1: Vector2, p2: Vector2, thickness: float) -> PackedVector2Array:
	var direction = (p2 - p1).normalized()
	var perpendicular = Vector2(-direction.y, direction.x)
	
	var half_thickness = thickness / 2
	var offset = perpendicular * half_thickness
	
	var points = PackedVector2Array([
		p1 + offset,
		p1 - offset,
		p2 - offset,
		p2 + offset
	])
	return points
