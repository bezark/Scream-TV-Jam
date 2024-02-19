extends Node3D

@onready var tv = $TV

@onready var baby_tv = $BabyTV
@onready var eat = $UI/Eat
@onready var animations = $Animations

var baby_in_range = false
var baby_eaten = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !baby_eaten:
		if baby_in_range && baby_tv.on_screen:
			eat.show()
		else:
			eat.hide()


func _on_baby_tv_interactable(object, actor, truth):
	if truth && object.on_screen:
		baby_in_range = true
	else:
		baby_in_range = false

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		if eat.visible:
			eat.hide()
			baby_eaten = true
			$Person/StateMachine/Initial.eat_baby()
			animations.play("eat_baby")


func _on_animations_animation_finished(anim_name):
	if anim_name == "eat_baby":
		$Person/StateMachine/Eating.done_eating()
		$TV/StateMachine.on_child_transition($TV/StateMachine.current_state, "Controlled")
		$BabyTV.queue_free() 
