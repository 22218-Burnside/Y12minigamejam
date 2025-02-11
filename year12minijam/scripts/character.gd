extends CharacterBody2D

var canflip = true
var flip = 1
const gravity = 700
const SPEED = 6
const JUMP_VELOCITY = -500.0


func _physics_process(delta: float) -> void:
	_movement(delta)


func _movement(delta:float):
	if Input.is_action_just_pressed("player_flip") and canflip:
		canflip = false
		$flip_timer.start()
		if flip == 1:
			$Sprite2D.flip_v = true
		else:
			$Sprite2D.flip_v = false
		flip *= -1
	# Add the gravity.
	if not is_on_floor() and flip == 1:
		velocity.y += gravity * delta * flip
	if not is_on_ceiling() and flip == -1:
		velocity.y += gravity * delta * flip
	
	if Input.is_action_pressed("player_left"):
		position.x -= SPEED
	if Input.is_action_pressed("player_right"):
		position.x += SPEED
	# Handle jump.
	if Input.is_action_pressed("player_jump") and is_on_floor() and flip == 1:
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("player_jump") and is_on_ceiling() and flip == -1:
		velocity.y = JUMP_VELOCITY * flip
	move_and_slide()


func _on_flip_timer_timeout() -> void:
	canflip = true
