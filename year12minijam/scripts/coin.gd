extends CharacterBody2D
var can_pickup = false
var flip = 1
var bounce_up = true
signal picked_up
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flip = get_parent().get_node("character").flip
	picked_up.connect(get_parent().get_node("character")._on_coin_picked_up)
	picked_up.connect(get_parent()._on_coin_picked_up)
	picked_up.connect(get_parent().get_node("healthbar")._on_coin_picked_up)
	$Area2D/AnimatedSprite2D.play("spin")
	velocity.y = flip * -1 * 500
	await get_tree().create_timer(0.5).timeout
	velocity.y = 0
	bounce_up = false
	can_pickup = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	velocity.x = 0
	if not bounce_up:
		if not is_on_ceiling() and not is_on_floor():
			velocity.y = flip * 250
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "character" and can_pickup:
		picked_up.emit()
		queue_free()
