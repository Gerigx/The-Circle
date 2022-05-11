extends KinematicBody2D

export var speed : int = 100
export var gravity : int = 200

var is_moving_right = true



var vel = Vector2.ZERO

func _process(delta):
	move_character()
	detect_turn_around()

	
	vel = move_and_slide(vel, Vector2.UP)

func move_character():
	
	vel.x = speed if is_moving_right else -speed
	vel.y += gravity
	

	

func detect_turn_around():
	if not $bottom.is_colliding() or  $side.is_colliding() and is_on_floor():
		is_moving_right = !is_moving_right
		scale.x = -scale.x
		print("turn")
		#$deadSound.play()
	

		
		

func hit():
	$AttackDetector.monitoring = true

func end_of_hit():
	$AttackDetector.monitoring = false



func _on_PlayerDetector_body_entered(body):
	queue_free()


	


func _on_AttackDetector_body_entered(body):
	get_tree().change_scene("res://Over.tscn")
