extends CharacterBody2D

var canflip = true
var flip = 1
const gravity = 700
var SPEED = 12
var sprint_bar = 100
var can_sprint = true
var running = false
var release_sprint = true
const JUMP_VELOCITY = -500.0


#Sound effect variables
@onready var gravity_inverted = $gravity_inverted
@onready var walking_forest = $walking_forest


func _physics_process(delta: float) -> void:
	_movement(delta)


func _movement(delta:float):
	$sprint_amount.text = str(sprint_bar)
	if running:
		SPEED = 20
		sprint_bar -= 1
	if not running:
		SPEED = 8
		if sprint_bar <100:
			sprint_bar += 0.5
	if Input.is_action_pressed("player_sprint") and sprint_bar >5 and can_sprint and release_sprint:
		running = true
		release_sprint = false
	if not Input.is_action_pressed("player_sprint") or sprint_bar <5:
		running = false
	if Input.is_action_just_released("player_sprint"):
		SPEED = 8
		can_sprint = false
		running = false
		release_sprint =true	
		$sprint_timer.start(1)
	if Input.is_action_just_pressed("player_flip") and canflip:
		canflip = false
		$flip_timer.start()
		gravity_inverted.play()
		if flip == 1:
			$AnimatedSprite2D.flip_v = true
		else:
			$AnimatedSprite2D.flip_v = false
	 	 gravity_inverted.play()
		flip *= -1
	# Add the gravity.
		if not is_on_floor() and flip == 1:
			velocity.y += gravity * delta * flip
		if not is_on_ceiling() and flip == -1:
			velocity.y += gravity * delta * flip
	if Input.is_action_pressed("player_left"):
		position.x -= SPEED
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("player_right"):
		position.x += SPEED
	walking_forest.play() 
		$AnimatedSprite2D.flip_h = false
	# Handle jump.
	if Input.is_action_pressed("player_jump") and is_on_floor() and flip == 1:
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("player_jump") and is_on_ceiling() and flip == -1:
		velocity.y = JUMP_VELOCITY * flip
	move_and_slide()


func _on_flip_timer_timeout() -> void:
	canflip = true


func _on_sprint_timer_timeout() -> void:
	can_sprint = true
