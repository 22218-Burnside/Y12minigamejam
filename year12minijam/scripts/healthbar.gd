extends CanvasLayer
@onready var progress_bar = $sprint_bar

var health = 3

func _ready() -> void:
	$ColorRect.show()
	$AnimationPlayer.play("black_to_clear")

func _process(_delta: float) -> void:
	var character = get_parent().get_node("character")
	var stamina = character.sprint_bar
	var max_stamina = 200.0  # Adjust if your max stamina is different

	var stamina_percent = stamina / max_stamina  # Ensures a smooth transition (0 to 1)
	progress_bar.value = stamina

	# Interpolates from green (full) to red (empty)
	progress_bar.modulate = Color(1 - stamina_percent, stamina_percent, 0)

func _on_character_healthbar(healthbar) -> void:
	health = healthbar
	if health == 2:
		$Sprite2D3.hide()
	if health == 1:
		$Sprite2D2.hide()
	if health == 0:
		$Sprite2D.hide()
