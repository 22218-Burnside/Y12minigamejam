extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$character/Camera2D.enabled = true
	$character.level = 1
	$cave_ambience.play()
	$character/Camera2D.limit_top =0
	$character/Camera2D.limit_bottom = 1080


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "character":
		$healthbar/AnimationPlayer.play("clear_to_black")
		await get_tree().create_timer(1).timeout
		get_tree().call_deferred("change_scene_to_file", "res://scenes/forest.tscn")
