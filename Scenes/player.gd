extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 1000
const FALLING_GRAV = 1500
const DASH_GRAV = 0
const DASH_SPEED = 900

var dashing = false
var can_dash = true


#Changes Gravity When Falling
func fall_grav(velocity: Vector2):
		if dashing:
			return DASH_GRAV
		else:
			if velocity.y < 0:
				return GRAVITY
			return FALLING_GRAV



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += fall_grav(velocity) * delta

	# Handle jump.
	# Variable Jump Height
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY/2.5
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Handles Dash
	if Input.is_action_just_pressed("Dash") and not is_on_floor() and can_dash:
		dashing = true
		can_dash = false
		velocity.y = 0
		$Dash_Timer.start()
		$canDash_Timer.start()
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Move_Left", "Move_Right")
	if direction:
		if dashing:
				velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func _on_dash_timer_timeout() -> void:
	dashing = false
	velocity.x = 0

func _on_can_dash_timer_timeout() -> void:
	can_dash = true
