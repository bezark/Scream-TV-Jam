extends State
class_name Chasing
@export var character : CharacterBody3D 

@onready var nav_agent = $"../../NavAgent"

func Enter():
	nav_agent.target_position = character.target.position

func Update(delta):
	character.SPEED += 0.005
	nav_agent.target_position = character.target.position
	character.look_at(nav_agent.target_position)
	var current_position = character.global_position
	if !nav_agent.is_navigation_finished():
		#nav_agent.set_target_position(character.target.position)
		var next_position = nav_agent.get_next_path_position()
		var new_velocity = next_position- current_position
		new_velocity = new_velocity.normalized()* character.SPEED
		character.velocity = new_velocity

func out_of_range():
	Transitioned.emit(self, "Hunting")
