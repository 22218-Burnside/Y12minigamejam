extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$character.level = 2
	$forest_ambience.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "character":
		$healthbar/AnimationPlayer.play("clear_to_black")
		await get_tree().create_timer(1).timeout
		get_tree().call_deferred("change_scene_to_file", "res://scenes/clouds.tscn")
