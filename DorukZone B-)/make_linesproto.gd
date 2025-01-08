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
	line2d.add_point(start_pos)
	line.start = start_pos
	line2d.add_point(end_pos)
	line.end = end_pos
	line.keys = keys
	collision.polygon = [start_pos, end_pos]
	return line

func get_points():
	return [start, end]

func _on_body_entered(body):
	collided.emit(keys)
