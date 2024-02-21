extends CharacterBody3D
class_name tv

signal interactable
signal watch_val_changed
#TODO: change class into Agent base class for player and tvs alike...
@export var target : Node3D
var afraid_of_target = false
@export var distance_threshold = 30.
@export var SPEED = 5.0

@export_category("Watched")
@export var watched_value = 50.0
@export var watch_curve : Curve

var on_screen : bool


#const JUMP_VELOCITY = 4.5
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#
#
func _physics_process(delta):
	move_and_slide()
	
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()


func _on_area_body_entered(body):
	emit_signal("interactable", self, body, true)


func _on_area_body_exited(body):
	emit_signal("interactable", self, body, false)

func change_watched_value(val):
	watched_value += val
	%Watched.value = watched_value
	watched_value = %Watched.value
	Globals.progress = watched_value
	emit_signal("watch_val_changed", watched_value)
