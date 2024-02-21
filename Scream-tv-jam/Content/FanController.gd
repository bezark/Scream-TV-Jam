extends Node3D

var fans 
# Called when the node enters the scene tree for the first time.
func _ready():
	fans = get_children()
	for fan in fans:
		fan.speed= randf_range(0.01, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
