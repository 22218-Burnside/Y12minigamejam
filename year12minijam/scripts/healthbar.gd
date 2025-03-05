extends CanvasLayer

var health = 3
func _process(_delta: float) -> void:
	$TextureProgressBar.value = get_parent().get_node("character").sprint_bar
func _on_character_healthbar(healthbar) -> void:
	health = healthbar
	if health == 2:
		$Sprite2D3.hide()
	if health == 1:
		$Sprite2D2.hide()
	if health == 0:
		$Sprite2D.hide()
