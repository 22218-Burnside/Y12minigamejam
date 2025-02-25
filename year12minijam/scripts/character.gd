extends CharacterBody2D
var health = 3
var canflip = true
var flip = 1
const gravity = 1000
var SPEED = 8
var sprint_bar = 100
var can_sprint = true
var release_sprint = true
var jump_reset = true
var squish_power = 1
var slime_velocity = false
var direction = 1
var falling = false
var idle = false
var walking = false
var running = false
const JUMP_VELOCITY = -500.0


#Sound effect variables
@onready var gravity_inverted = $gravity_inverted
@onready var walking_forest = $walking_forest
@onready var gravity_normal = $gravity_normal

func _physics_process(delta: float) -> void:
	if health <1:
		get_tree().change_scene_to_file("res://scenes/deathscreen.tscn")
	_movement(delta)
	_animations()
	_sounds()


func _movement(delta:float):
	$sprint_amount.text = str(sprint_bar)
	if running:
		SPEED = 12
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
		$flip_timer.start()
		flip *= -1
	# Add the gravity.
	if Input.is_action_pressed("player_left"):
		direction = -1
		position.x -= SPEED
	if Input.is_action_pressed("player_right"):
		direction = 1
		position.x += SPEED
	if not is_on_floor() and flip == 1:
		velocity.y += gravity * delta * flip
	if not is_on_ceiling() and flip == -1:
		velocity.y += gravity * delta * flip
	if is_on_floor() or is_on_ceiling() and squish_power == 3:
		squish_power = 1
	if Input.is_action_pressed("player_jump") and is_on_floor() and flip == 1 and not slime_velocity:
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("player_jump") and is_on_ceiling() and flip == -1 and not slime_velocity:
		velocity.y = JUMP_VELOCITY * flip
	if is_on_floor() or is_on_ceiling() and not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right"):
		slime_velocity = false
		velocity.x = 0
	move_and_slide()
	


func _animations():
	if Input.is_action_pressed("player_left"):
		walking = true
		$AnimatedSprite2D.flip_h = true
		if walking and not falling:
			if flip == 1:
				$AnimatedSprite2D.play("Run")
			if flip == -1:
				$AnimatedSprite2D.play("Run_red")
	if Input.is_action_pressed("player_right"):
		walking = true
		$AnimatedSprite2D.flip_h = false
		if walking and not falling:
			if flip == 1:
				$AnimatedSprite2D.play("Run")
			if flip == -1:
				$AnimatedSprite2D.play("Run_red")
	if not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and is_on_floor():
		walking = false
		falling = false
		$AnimatedSprite2D.play("Idle")
	if not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and is_on_ceiling():
		walking = false
		falling = false
		$AnimatedSprite2D.play("Idle_red")
	if is_on_ceiling() or is_on_floor():
		falling = false
	if not is_on_floor() and flip == 1:
		falling = true
		$AnimatedSprite2D.play("Fall")
	if not is_on_ceiling() and flip == -1:
		falling = true
		$AnimatedSprite2D.play("Fall_red")



func _sounds():
	if Input.is_action_just_pressed("player_flip")and canflip:
		canflip = false
		if flip == -1:
			$AnimatedSprite2D.flip_v = true
			gravity_inverted.play()
		if flip == 1:
			$AnimatedSprite2D.flip_v = false
			gravity_normal.play()
	if Input.is_action_pressed("player_left"):
		if not walking_forest.is_playing() and is_on_floor():
			walking_forest.play()
		if not walking_forest.is_playing() and is_on_ceiling():
			walking_forest.play()
		elif not is_on_floor() and not is_on_ceiling():
			walking_forest.stop()
	if Input.is_action_pressed("player_right"):
		if not walking_forest.is_playing() and is_on_floor():
			walking_forest.play()
		if not walking_forest.is_playing() and is_on_ceiling():
			walking_forest.play()
		elif not is_on_floor() and not is_on_ceiling():
			walking_forest.stop()
	if not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and is_on_floor():
		walking_forest.stop()
	if not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and is_on_ceiling():
		walking_forest.stop()



#Connected Node Functions

func _on_flip_timer_timeout() -> void:
	canflip = true

func _on_sprint_timer_timeout() -> void:
	can_sprint = true


func _on_enemy_hit_player() -> void:
	health -= 1


func _on_enemy_squished() -> void:
	slime_velocity = true
	velocity = Vector2(randi_range(250,400)* direction, randi_range(-400,-650)* flip)


func _on_enemy_pop() -> void:
	$pop.play()
