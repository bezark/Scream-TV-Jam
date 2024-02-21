extends State

@export var character : CharacterBody3D 

@onready var animation_player = $"../../AnimationPlayer"


func Enter():
	character.target.visible = false
	Globals.dead.emit()
	character.velocity = Vector3.ZERO
	animation_player.play("horror")
	$"../../Sound/bleh".play()


func _on_animation_player_animation_finished(anim_name):

	Globals.reset.emit()
	Transitioned.emit(self, "Initial")
