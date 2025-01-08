extends Node2D

var path = preload("res://Assets/A4 Piano.wav")

static var frequency := {
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
static var scales:={
	"Cmaj": ["C", "D", "E", "F", "G", "A", "B"],
	"Cm": ["C", "D", "D#", "F", "G", "G#", "A#"],
	"Cdorian": ["C", "D", "D#", "F", "G", "A", "A#",],
	"Caeorian": ["C", "D", "D#", "F", "G", "G#", "A#"],
	"Cblues": ["C", "D", "D#", "E", "G", "A"],
	"Cphrygian": ["C", "C#", "D#", "F", "G", "G#", "A#"]
	}
@export_enum("Cmaj", "Cm", "Cdorian", "Caeorian", "Cblues", "Cphyrgian") var chosen_scale = "Cmaj"

static var dyads:= [
		[[0,0],[2,0]],[[0,0],[4,-1]],[[0,0],[4,0]],[[2,0],[4,0]],[[0,0],[6,-1]],[[0,0],[6,0]],[[3,0],[6,0]]
	]

static var action_pitch:= {
	"1": [0,0.25],
	"2": [1,0.25], 
	"3": [2,0.25],
	"4": [3,0.25],
	"5": [4,0.25],
	"6": [5,0.25],
	"7": [6,0.25],
	"8": [0,0.25],
	"9": [1,0.5],
	"0": [2,0.5],
	"Q": [3,0.5],
	"W": [4,0.5],
	"E": [5,0.5],
	"R": [6,0.5],
	"T": [0,1],
	"Y": [1,1],
	"U": [2,1],
	"I": [3,1],
	"O": [4,1],
	"P": [5,1],
	"A": [6,1],
	"S": [0,2],
	"D": [1,2],
	"F": [2,2],
	"G": [3,2],
	"H": [4,2],
	"J": [5,2],
	"K": [6,2],
	"L": [0,4],
	"Z": [1,4],
	"X": [2,4],
	"C": [3,4],
	"V": [4,4],
	"B": [5,4],
	"N": [6,4],
	"M": [0,8]
}
var keys_played: Array


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	for action in action_pitch.keys():
		if event.is_action_pressed(action) and action not in keys_played:
			keys_played.append(action)
			var dyad = dyads[action_pitch[action][0]]
			var pitch = action_pitch[action][1]

			var players: Array
			for note in dyad:
				var player = AudioStreamPlayer.new()
				players.append(player)
				add_child(player)
				player.stream = path
				var named_note = scales[chosen_scale][note[0]+note[1]]
				player.pitch_scale = frequency[named_note]*pitch/440.0
				player.play()
			
			for player in players:
				await get_tree().create_timer(8.0).timeout
				player.queue_free()
				
		elif event.is_action_released(action) and action in keys_played:
			keys_played.erase(action)
	
		
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
