extends State
class_name RunAway

@export var character : CharacterBody3D 

var NavAgent



func _ready():
	NavAgent = character.get_node("NavAgent")
	NavAgent.path_desired_distance = 5
	NavAgent.target_desired_distance = 1.
	run_from(Vector3(100000,1,0))
	
func Enter():
	#NavAgent.set_target_position(character.target.position)
	run_from(Vector3(100,1,1000))
	pass

func run_from(pos):
	var closest_pos = NavigationServer3D.map_get_closest_point(character.get_world_3d().get_navigation_map(),pos)
	print(closest_pos)
	print(character.get_world_3d().get_navigation_map())
