extends State
class_name HappyBroadcast

@export var character : CharacterBody3D

func Enter():
	character.target = get_tree().get_first_node_in_group("player")
	print("TV IDLE Entered")
	
func Update(delta: float):
	#print("TV idling")
	pass


func _on_area_body_exited(body):
	if body == character.target:
		print("Don't go...")
		Transitioned.emit(self, "anxious")


