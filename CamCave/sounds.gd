extends Node2D
var path = preload("res://Assets/A4 Piano.wav")

var fourth_note_frequencies := {
	"C": 261.63,
	"C#": 277.18,
	"D": 293.66,
	"D#": 311.13,
	"E": 329.63,
	"F": 349.23,
	"F#": 369.99,
	"G": 392.00,
	"G#": 415.30,
	"A": 440.00,
	"A#": 466.16,
	"B": 493.88
}
var scales:={
	"Cmaj": ["C", "D", "E", "F", "G", "A", "B", "C'"]
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _input(event):
	#var audio = $Audio
	if(event.is_action_pressed("Q")):
		$AudioQ.stream = path
		$AudioQ.pitch_scale = 261.63/440.00
		$AudioQ.play()
	if(event.is_action_pressed("W")):
		$AudioW.stream = path
		$AudioW.pitch_scale = 293.63/440.00
		$AudioW.play()
	if(event.is_action_pressed("E")):
		$AudioE.stream = path
		$AudioE.pitch_scale = 329.63/440.00
		$AudioE.play()
	if(event.is_action_pressed("R")):
		$AudioR.stream = path
		$AudioR.pitch_scale = 349.23/440.00
		$AudioR.play()
	if(event.is_action_pressed("T")):
		$AudioT.stream = path
		$AudioT.pitch_scale = 392.00/440.00
		$AudioT.play()
	if(event.is_action_pressed("Y")):
		$AudioY.stream = path
		$AudioY.pitch_scale = 1
		$AudioY.play()
	if(event.is_action_pressed("U")):
		$AudioU.stream = path
		$AudioU.pitch_scale = 493.88/440.00
		$AudioU.play()
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
