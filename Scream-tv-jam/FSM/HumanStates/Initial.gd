extends State
class_name Initial

@export var character : CharacterBody3D 

func Enter():
	$"../../SquareEyes".hide()
	$"../../Camera3D".make_current()
func Exit():
	character.player_controlled = false	
	
	
func Update(delta):
	pass

func Physics_Update(delta):
	pass
	#if not character.is_on_floor():
		#character.velocity.y -= character.gravity * delta
#
	## Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and character.is_on_floor():
		#character.velocity.y = character.JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("left", "right", "up", "down")
	#var direction = (character.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#character.velocity.x = direction.x * character.SPEED
		#character.velocity.z = direction.z * character.SPEED
	#else:
		#character.velocity.x = character.move_toward(character.velocity.x, 0, character.SPEED)
		#character.velocity.z = character.move_toward(character.velocity.z, 0,character.SPEED)
	#
	#if Input.is_action_just_pressed("pause"):
		#character.mouse_captured = !character.mouse_captured
		#
		#if character.mouse_captured:
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		#else:
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#character.rotate_camera(delta)

func eat_baby():
	Transitioned.emit(self, "Eating")
