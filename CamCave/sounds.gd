extends Node2D

@export var path = preload("res://Assets/synth2.wav")
@export var chord_path = preload("res://Assets/bass a4.wav")

#@export var lines_ref: Line

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
enum escales {
	major, minor, dorian, aeorian, phrygian
}

static var scales:={
	escales.major: ["C", "D", "E", "F", "G", "A", "B"],
	escales.minor: ["C", "D", "D#", "F", "G", "G#", "A#"],
	escales.dorian: ["C", "D", "D#", "F", "G", "A", "A#",],
	escales.aeorian: ["C", "D", "D#", "F", "G", "G#", "A#"],
	escales.phrygian: ["C", "C#", "D#", "F", "G", "G#", "A#"]
	}
@export var chosen_scale : escales

static var dyads:= [
		[[0,0],[2,0]],
		[[0,0],[4,-1]],
		[[0,0],[4,0]],
		[[2,0],[5,0]],
		[[0,0],[6,-1]],
		[[0,0],[6,0]],
		[[4,0],[6,0]]
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
	path = preload("res://Assets/synth2.wav")
	chord_path = preload("res://Assets/synth2.wav")
	#lines_ref.collided.connect(play_chords)

func _input(event):
	for action in action_pitch.keys():
		if event.is_action_pressed(action) and action not in keys_played and keys_played.size()<=4:
			keys_played.append(action)
			var dyad = dyads[action_pitch[action][0]]
			var pitch = action_pitch[action][1]

			var players: Array
			for note in dyad:
				var player = AudioStreamPlayer.new()
				players.append(player)
				add_child(player)
				player.stream = path
				var named_note = scales[chosen_scale][note[0]]
				named_note = frequency.keys()[frequency.keys().find(named_note)+note[1]]
				player.pitch_scale = frequency[named_note]*pitch/440.0
				player.play()
			
			for player in players:
				await get_tree().create_timer(4.0).timeout
				player.queue_free()
				
		elif event.is_action_released(action) and action in keys_played:
			keys_played.erase(action)
	
		
	
func play_chords(keys: Array):
	
	var players: Array
	for key in keys:
		var dyad = dyads[action_pitch[key][0]]
		var pitch = action_pitch[key][1]

		for note in dyad:
			var player = AudioStreamPlayer.new()
			players.append(player)
			add_child(player)
			player.stream = chord_path
			var named_note = scales[chosen_scale][note[0]]
			named_note = frequency.keys()[frequency.keys().find(named_note)+note[1]]
			player.pitch_scale = frequency[named_note]*pitch/440.0
			player.play()
		
	for player in players:
		await get_tree().create_timer(4.0).timeout
		player.queue_free()


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_instrument_option_item_selected(index):
	match index:
		0:
			path = preload("res://Assets/synth2.wav")
			chord_path = preload("res://Assets/synth2.wav")
		1:
			path = preload("res://Assets/cs80 funky.wav")
			chord_path = preload("res://Assets/bass a4.wav")
		2:
			path = preload("res://Assets/A4 Piano.wav")
			chord_path = preload("res://Assets/A4 Piano.wav")
		3:
			path = preload("res://Assets/guitar a4.wav")
			chord_path = preload("res://Assets/guitar a4.wav")
		4:
			path = preload("res://Assets/newmarimba.wav")
			chord_path = preload("res://Assets/newmarimba.wav")
		5:
			path = preload("res://Assets/fluteA4.wav")
			chord_path = preload("res://Assets/fluteA4.wav")
		_:
			path = preload("res://Assets/synth2.wav")
			chord_path = preload("res://Assets/synth2.wav")


func _on_scale_option_item_selected(index):
	chosen_scale = index
