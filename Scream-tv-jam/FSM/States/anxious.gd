extends State
class_name Anxious

@export var character : CharacterBody3D 



func Enter():
	print("Billboard entered")
	
	
func Update(delta: float):
	character.look_at(character.target.position) #TODO: lerp me!
	if(character.position-character.target.position).length() >= character.distance_threshold:
		Transitioned.emit(self, "Move_to")


func _on_area_body_entered(body):	
	if body == character.target && !character.afraid_of_target:
		Transitioned.emit(self, "happy_broadcast")
	
