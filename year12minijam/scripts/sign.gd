extends Area2D
var can_read = false
var reading = false
var characters_visible = 0
signal player_reading
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Sprite2D2/Label.visible_characters = round(characters_visible)
	if reading:
		characters_visible += 0.2
		$Sprite2D2.show()
		$Label.visible_characters = 0
	else:
		$Sprite2D2.hide()
		$Label.visible_characters = 3
	if reading and Input.is_action_pressed("cancel_read"):
		$Sprite2D2.hide()
		reading = false
	if Input.is_action_just_pressed("player_interact") and can_read:
		reading = true
		player_reading.emit()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "character":
		can_read = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "character":
		can_read = false
