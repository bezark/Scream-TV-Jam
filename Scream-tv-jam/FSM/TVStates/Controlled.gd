extends State
class_name Controlled

@export var character : CharacterBody3D

var controlled = false

#
#func _on_area_body_exited(body):
	#if body == character.target:
		#print("Don't go...")
		#Transitioned.emit(self, "anxious")
#



@onready var watched = %Watched
var charging = false

const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var look_dir: Vector2

@export var camera_sensitivity = 50
@onready var camera = $"../../Camera3D"

@onready var beam = $"../../Beam"

func Enter():
	controlled = true
	character.target = get_tree().get_first_node_in_group("player")
	print("CONTROL")
	camera.make_current()
	watched.value = character.watched_value
	watched.show()
	character.SPEED = 5.0

func _ready():
	#TODO: Put back in capture
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#mouse_captured = true
	pass

func Update(delta):
	
	# Add the gravity.
	if controlled:
		#print(%Watched.value)
		var input_dir = Input.get_vector("left", "right", "up", "down")
	
		var direction = (character.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			character.velocity.x = direction.x * character.SPEED
			character.velocity.z = direction.z * character.SPEED
		else:
			character.velocity.x = move_toward(character.velocity.x, 0, character.SPEED)
			character.velocity.z = move_toward(character.velocity.z, 0, character.SPEED)
		
		rotate_camera(delta)
	
		#character.move_and_slide()
#/////////////////CHARGING
	if Input.is_action_just_pressed("jump"): #TODO: Change input from jump
		beam.visible = !beam.visible
		$"../../Beam/BeamRange".monitoring = !$"../../Beam/BeamRange".monitoring 
		if charging:
			charging = false
			character.targete.out_of_range()
	
	if charging:
		character.change_watched_value(0.5)
	else:
		character.change_watched_value(-0.25)
	
		
	
	
func _input(event):
	if controlled:
		if event is InputEventMouseMotion:
			look_dir = event.relative*0.01


func rotate_camera(delta: float, sensitivity_modifier: float = 1.0):
	character.rotation.y -= look_dir.x * camera_sensitivity* delta
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y *camera_sensitivity*sensitivity_modifier*delta, -1.5, 1.5)
	look_dir = Vector2.ZERO


func _on_beam_range_body_entered(body):
	if body.is_in_group("player")&& controlled:
		charging = true
		body.sees_tv(character)


func _on_beam_range_body_exited(body):
	if body.is_in_group("player"):
		charging = false
		body.out_of_range()
