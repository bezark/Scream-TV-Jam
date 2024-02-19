extends State
class_name Hunting

@onready var nav_agent = $"../../NavAgent"
@export var wander_range = 20.
@export var character : CharacterBody3D 
# Called when the node enters the scene tree for the first time.


func Enter():
	print("THE HUNT IS ON")
	nav_agent.target_position = pick_a_spot()
	$"../../SquareEyes".show()
	
func Update(delta):

	character.look_at(nav_agent.target_position)
	var current_position = character.global_position
	if !nav_agent.is_navigation_finished():
		#nav_agent.set_target_position(character.target.position)
		var next_position = nav_agent.get_next_path_position()
		var new_velocity = next_position- current_position
		new_velocity = new_velocity.normalized()* character.SPEED
		character.velocity = new_velocity
	else:
		nav_agent.target_position = pick_a_spot()
		
		
func pick_a_spot():
	var current_position = character.global_position
	var random_spot = Vector3(randf_range(current_position.x+wander_range, current_position.x-wander_range), 0., randf_range(current_position.z+wander_range, current_position.z-wander_range))
	var closest_pos = NavigationServer3D.map_get_closest_point(character.get_world_3d().get_navigation_map(),random_spot)
	print(closest_pos)
	return closest_pos
	

func start_chase():
	Transitioned.emit(self, "Chasing")
