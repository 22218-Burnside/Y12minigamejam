extends Area2D
var can_read
var reading = true
signal player_reading
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if reading:
		$Sprite2D2.show()
	else:
		$Sprite2D2.hide()
	if Input.is_action_just_pressed("player_interact") and can_read:
		reading = true
		player_reading.emit()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		can_read = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Character":
		can_read = false
