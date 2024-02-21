extends Node3D

@onready var person = $".."
@onready var footsteps = $Footsteps
@onready var footsteps_timer = $Footsteps/Timer

@export var low_speed = 10.
@export var high_speed = 0.5

@onready var panner = AudioServer.get_bus_effect(1, 1)
var left = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if person.walking:
		if not footsteps.playing and footsteps_timer.is_stopped():
			step()

func step():
	
	
	footsteps_timer.wait_time = remap(person.SPEED, 1.0, 20., low_speed, high_speed)
	if person.walking:
		if not footsteps.playing:
			footsteps.play()
			footsteps.pitch_scale += randf_range(-0.005,0.005)
			if left:
				panner.pan = -0.4
				left = false
			else:
				left = true
				panner.pan = 0.4
		if footsteps_timer.is_stopped():
			footsteps_timer.start()


func _on_timer_timeout():
	step()
