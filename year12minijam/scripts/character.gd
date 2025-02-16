extends CharacterBody2D

var canflip = true
var flip = 1
const gravity = 700
const SPEED = 6
const JUMP_VELOCITY = -500.0

#Sound effect variables
@onready var gravity_inverted = $gravity_inverted
@onready var walking_forest = $walking_forest


func _physics_process(delta: float) -> void:
	_movement(delta)


func _movement(delta:float):
	if Input.is_action_just_pressed("player_flip") and canflip:
		canflip = false
		$flip_timer.start()
		if flip == 1:
			$Sprite2D.flip_v = true
			gravity_inverted.play()
		else:
			$Sprite2D.flip_v = false
			gravity_inverted.play()
		flip *= -1
	# Add the gravity.
	if not is_on_floor() and flip == 1:
		velocity.y += gravity * delta * flip
	if not is_on_ceiling() and flip == -1:
		velocity.y += gravity * delta * flip
	
	if Input.is_action_pressed("player_left"):
		position.x -= SPEED
		walking_forest.play() 
		# Right now, there is no way to switch the SFX between scenes yet.
		# This means the forest_SFX will play throughout all scenes.
	if Input.is_action_pressed("player_right"):
		position.x += SPEED
		walking_forest.play()
	# Handle jump.
	if Input.is_action_pressed("player_jump") and is_on_floor() and flip == 1:
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("player_jump") and is_on_ceiling() and flip == -1:
		velocity.y = JUMP_VELOCITY * flip
	move_and_slide()


func _on_flip_timer_timeout() -> void:
	canflip = true
