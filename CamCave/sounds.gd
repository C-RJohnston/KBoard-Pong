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
static var modes:={
	"dorian": ["C", "D", "D#", "F", "G", "A", "A#",],
	"aeorian": ["C", "D", "D#", "F", "G", "G#", "A#"]
	}

static var dyads:= [
	["C", "D#"],["C", "F#"],["C", "G"],["C", "A"], ["C", "A#"]
	]

static var action_pitch:= {
	"1": [0.0,0.125],
	"2": [1.0,0.125], 
	"3": [2.0,0.125],
	"4": [3.0,0.125],
	"5": [4.0,0.125],
	"6": [0.0,0.25],
	"7": [1.0,0.25],
	"8": [2.0,0.25],
	"9": [3.0,0.25],
	"0": [4.0,0.25],
	"Q": [0.0,0.5],
	"W": [1.0,0.5],
	"E": [2.0,0.5],
	"R": [3.0,0.5],
	"T": [4.0,0.5],
	"Y": [0.0,1],
	"U": [1.0,1],
	"I": [2.0,1],
	"O": [3.0,1],
	"P": [4.0,1],
	"A": [0,2],
	"S": [1,2],
	"D": [2,2],
	"F": [3,2],
	"G": [4,2],
	"H": [0,4],
	"J": [1,4],
	"K": [2,4],
	"L": [3,4],
	"Z": [4,4],
	"X": [0,8],
	"C": [1,8],
	"V": [2,8],
	"B": [3,8],
	"N": [4,8],
	"M": [0,16]
}
var keys_played: Array


@onready var players = $Players.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	for action in action_pitch.keys():
		if event.is_action_pressed(action) and action not in keys_played:
			keys_played.append(action)
			var dyad = dyads[action_pitch[action][0]]
			var pitch = action_pitch[action][1]
			for i in range(len(players)):
				players[i].pitch_scale = frequency[dyad[i]]*pitch/440.00
				players[i].play()
		elif event.is_action_released(action) and action in keys_played:
			keys_played.erase(action)
	
		
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
