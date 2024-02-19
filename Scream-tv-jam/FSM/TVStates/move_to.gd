extends State
class_name Move_to

@export var character : CharacterBody3D 
var NavAgent



func _ready():
	NavAgent = character.get_node("NavAgent")
	NavAgent.path_desired_distance = 5
	NavAgent.target_desired_distance = 1.

func Enter():
	print("following")
	NavAgent.set_target_position(character.target.position)
	
func Update(delta):
	#if(character.position-character.target.position).length() <= character.distance_threshold/4:
		#Transitioned.emit(self, "anxious")
	#else:
	character.look_at(character.target.position)
	var current_position = character.global_position
	if !character.on_screen:
		if !NavAgent.is_navigation_finished():
			NavAgent.set_target_position(character.target.position)
			var next_position = NavAgent.get_next_path_position()
			var new_velocity = next_position- current_position
			new_velocity = new_velocity.normalized()* character.SPEED
			character.velocity = new_velocity
		else:
			#character.look_at(character.target.position)
			Transitioned.emit(self, "anxious")
	else:
		character.velocity = Vector3(0.,0.,0.)

func Exit():
	character.velocity = Vector3(0.,0.,0.)



func _on_visibile_screen_entered():
	character.on_screen = true



func _on_visibile_screen_exited():
	character.on_screen = false
	


func _on_nav_agent_velocity_computed(safe_velocity):
	character.velocity = safe_velocity
