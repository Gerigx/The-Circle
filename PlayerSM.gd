extends "res://StateMachine.gd"

func _ready():
	add_state("idle")
	add_state("move")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle) # setzt den start status auf idle

func _state_logic(delta):
	parent._get_input()
	parent._apply_jump()
	

func _get_transition(delta):
	return null

func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass
