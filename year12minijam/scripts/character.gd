extends CharacterBody2D
var health = 3
var canflip = true
var flip = 1
const gravity = 700
var SPEED = 12
var sprint_bar = 100
var can_sprint = true
var running = false
var release_sprint = true
var jump_reset = true
var squish_power = 1
const JUMP_VELOCITY = -500.0


#Sound effect variables
@onready var gravity_inverted = $gravity_inverted
@onready var walking_forest = $walking_forest


func _physics_process(delta: float) -> void:
	if health <1:
		print("DIE")
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
		squish_power = 3
		canflip = false
		$flip_timer.start()
		if flip == 1:
			$AnimatedSprite2D.flip_v = true
			gravity_inverted.play()
		else:
			$AnimatedSprite2D.flip_v = false
		flip *= -1
	# Add the gravity.
	if not is_on_floor() and flip == 1:
		velocity.y += gravity * delta * flip
	if not is_on_ceiling() and flip == -1:
		velocity.y += gravity * delta * flip
	if Input.is_action_pressed("player_left"):
		$AnimatedSprite2D.play("Run")
		position.x -= SPEED
		walking_forest.play()
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("player_right"):
		$AnimatedSprite2D.play("Run")
		position.x += SPEED
		walking_forest.play() 
		$AnimatedSprite2D.flip_h = false
	if not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and is_on_floor():
		$AnimatedSprite2D.play("Idle")
	if is_on_floor() or is_on_ceiling() and squish_power == 3:
		squish_power = 1
	if Input.is_action_pressed("player_jump") and is_on_floor() and flip == 1:
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("player_jump") and is_on_ceiling() and flip == -1:
		velocity.y = JUMP_VELOCITY * flip
	if is_on_floor() or is_on_ceiling() and not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right"):
		velocity.x = 0
	move_and_slide()

func _on_flip_timer_timeout() -> void:
	canflip = true

func _on_sprint_timer_timeout() -> void:
	can_sprint = true


func _on_enemy_hit_player() -> void:
	health -= 1
