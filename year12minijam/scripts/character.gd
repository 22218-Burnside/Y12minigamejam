extends CharacterBody2D
var health = 3
var canflip = true
var flip = 1
const gravity = 1000
var SPEED = 300
var sprint_bar = 200
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
var jumping = false
var level = 1
var flip_reset = 3
const JUMP_VELOCITY = -550.0

signal healthbar
signal shake
#Sound effect variables
@onready var gravity_inverted = $gravity_inverted
@onready var walking_forest = $walking_forest
@onready var gravity_normal = $gravity_normal

func _ready() -> void:
	healthbar.connect(get_parent().get_node("healthbar")._on_character_healthbar)
func _physics_process(delta: float) -> void:
	if position.y > 1100 or position.y <0 or health < 1:
		if level == 1:
			get_tree().change_scene_to_file("res://scenes/cavedeath.tscn")
		if level == 2:
			get_tree().change_scene_to_file("res://scenes/forestdeath.tscn")
		if level == 3:
			get_tree().change_scene_to_file("res://scenes/clouddeath.tscn")
	_movement(delta)
	_animations()
	_sounds()


func _movement(delta:float):
	$sprint_amount.text = str(sprint_bar)
	if running:
		SPEED = 750
		sprint_bar -= 1
	if not running:
		SPEED = 500
		if sprint_bar <200:
			sprint_bar += 1
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
	if Input.is_action_just_pressed("player_flip") and canflip and flip_reset > 0:
		velocity.y *= 0.5
		squish_power = 3
		$flip_timer.start()
		flip *= -1
	if Input.is_action_pressed("player_left"):
		direction = -1
		walking = true
	if Input.is_action_pressed("player_right"):
		direction = 1
		walking = true
	if walking:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and not slime_velocity:
		velocity.x *= 0.5
	if not is_on_floor() and flip == 1:
		velocity.y += gravity * delta * flip
	if not is_on_ceiling() and flip == -1:
		velocity.y += gravity * delta * flip
	if is_on_floor() and flip == 1 and squish_power == 3:
		shake.emit()
		squish_power = 1
	if is_on_ceiling() and flip == -1 and squish_power == 3:
		shake.emit()
		squish_power = 1
	if Input.is_action_pressed("player_jump") and is_on_floor() and flip == 1 and not slime_velocity:
		velocity.y = JUMP_VELOCITY
		jumping = true
	if Input.is_action_pressed("player_jump") and is_on_ceiling() and flip == -1 and not slime_velocity:
		velocity.y = JUMP_VELOCITY * flip
		jumping = true
	if is_on_floor() and flip == 1 and squish_power == 3:
		shake.emit()
		squish_power = 1
	if is_on_ceiling() and flip == -1 and squish_power == 3:
		shake.emit()
		squish_power = 1
	if is_on_floor():
		if flip_reset < 2:
			flip_reset = 2
		if slime_velocity:
			velocity.x = 0
		slime_velocity = false
	if is_on_ceiling():
		if flip_reset < 2:
			flip_reset = 2
		if slime_velocity:
			velocity.x = 0
		slime_velocity = false
	move_and_slide()
	


func _animations():
	if Input.is_action_just_pressed("player_flip")and canflip and flip_reset > 0:
		if flip == -1:
			$AnimatedSprite2D.flip_v = true
		if flip == 1:
			$AnimatedSprite2D.flip_v = false
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
	if Input.is_action_just_pressed("player_flip")and canflip and flip_reset >0:
		flip_reset -=1
		if flip == -1:
			gravity_inverted.play()
		if flip == 1:
			gravity_normal.play()
		canflip = false
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
	healthbar.emit(health)


func _on_enemy_squished() -> void:
	slime_velocity = true
	velocity = Vector2(randi_range(500,750)* direction, randi_range(-400,-650)*flip)


func _on_enemy_pop() -> void:
	$pop.play()
