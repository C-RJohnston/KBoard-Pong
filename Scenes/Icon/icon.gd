extends Node2D

@export var wiggle_speed = 10
@export var wiggle_amount = 0.05
var wiggle_timer = 0
var wiggle = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wiggle:
		wiggle_timer += delta * wiggle_speed
		rotation = sin(wiggle_timer) * wiggle_amount

func pressed():
	wiggle = true
	$Sprite2D.modulate = Color(2,2,2,1)
	$Particles.emitting = true

func released():
	wiggle = false
	$Sprite2D.modulate = Color(1,1,1,1)
	$Particles.emitting = false
