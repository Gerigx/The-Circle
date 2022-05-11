extends KinematicBody2D

# Signals
signal health_updated(health)
signal killed()

# Speed
var speed_max2 : int = 300
var speed_max : int = 300
export var speed_acs : int = 5

# Rotation
var rotation_dir : int = 0
var rotation_spd : int = 10

# Jump
var gravity : int = 10
var Jump_force : int = -500
var coyote_jump : bool = true
var jump_was_pressed : bool = false

# Velocity
var vel : Vector2 = Vector2()

# life
var health_max : int = 3
onready var health = health_max setget _set_health
onready var invulnerability_timer = $invulnerability

onready var sprite : Sprite = get_node("Gj-MiniPlayer2")

func _ready():
	
	self.global_position = GlobalScript.player_initial_map_position

func _get_Input():
	rotation_dir = 0
	
	# Input links
	if Input.is_action_pressed("move_left"):
		
		rotation_dir = -1
		vel.x = max(vel.x - speed_acs, -speed_max)			
		
		
	elif Input.is_action_pressed("move_right"):
		
		rotation_dir = 1
		vel.x = min(vel.x + speed_acs, speed_max)			
		
			
	else:
		vel.x = lerp(vel.x, 0 , 0.1) # decrease velocity
		
		
		
		# start state machine
#func _apply_jump():
	if is_on_floor():
		coyote_jump = true
		if jump_was_pressed == true:
			vel.y = Jump_force

		
	if Input.is_action_just_pressed("jump"):
		jump_was_pressed = true
		_jump_released()
		if coyote_jump == true:
			vel.y = Jump_force
			
		
	
	if !is_on_floor():
		_coyote_time()
		vel.y += gravity
		

		
	

func _coyote_time():
	yield(get_tree().create_timer(.3), "timeout")
	coyote_jump = false
	pass
	
	
func _jump_released():
	yield(get_tree().create_timer(.5), "timeout")
	jump_was_pressed = false
	pass

func _physics_process(delta):
	
	_get_Input()
	
	vel = move_and_slide(vel, Vector2.UP)
	rotation += rotation_dir * rotation_spd * delta
	

func damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		_set_health(health - amount)

func kill():
	queue_free()
	

func _set_health(value):
	var prev_health : int = health
	health = clamp(value, 0, health_max)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()
			emit_signal("killed")
