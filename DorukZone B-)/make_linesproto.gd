class_name Line
extends RigidBody2D
static var scene = preload("res://DorukZone B-)/MakeLines.tscn")
signal collided(keys: Array)

var start
var end
var keys: Array

static func new_line(start_pos: Vector2, end_pos: Vector2, keys: Array):

	var line: Line = scene.instantiate()
	var line2d = line.get_child(0)
	var collision = line.get_child(1)
	var particles = line.get_child(2)
	line2d.add_point(start_pos)
	line.start = start_pos
	line2d.add_point(end_pos)
	line.end = end_pos
	line.keys = keys
	collision.polygon = [start_pos, end_pos]
	particles.position = (start_pos + end_pos) / 2
	particles.rotation = atan((end_pos.y - start_pos.y)/(end_pos.x-start_pos.x))
	particles.emission_rect_extents = Vector2((end_pos-start_pos).length()/2, 10)
	return line

func get_points():
	return [start, end]

func _on_body_entered(body):
	collided.emit(keys)
