extends State
class_name Move_to

@export var character : CharacterBody3D 
var NavAgent

func _ready():
	NavAgent = character.get_node("Senses/NavAgent")
	NavAgent.path_desired_distance = 5
	NavAgent.target_desired_distance = 1.

func Enter():
	print("following")
	NavAgent.set_target_position(character.target.position)
	
func Update(delta):
	if(character.position-character.target.position).length() <= character.distance_threshold/2:
		Transitioned.emit(self, "anxious")
	else:
		character.look_at(character.target.position)
		var current_position = character.position
		if !NavAgent.is_navigation_finished():
			var next_position = NavAgent.get_next_path_position()
			var new_velocity = next_position- current_position
			new_velocity = new_velocity.normalized()* character.SPEED
			character.velocity = new_velocity
		else:
			Transitioned.emit(self, "anxious")

func Exit():
	character.velocity = Vector3(0.,0.,0.)
