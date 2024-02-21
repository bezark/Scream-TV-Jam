extends MeshInstance3D

@export var speed = 0.5
@onready var blade = $Blade
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	blade.rotate_y(speed*delta)
