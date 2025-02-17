extends CharacterBody2D

var direction = 1
const SPEED = 3
const JUMP_VELOCITY = -400.0
var direction_change = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	position.x += SPEED * direction
	if is_on_wall() and direction_change:
		direction *= -1
		direction_change = false
		$direction_cooldown.start()

	move_and_slide()


func _on_direction_cooldown_timeout() -> void:
	direction_change = true
