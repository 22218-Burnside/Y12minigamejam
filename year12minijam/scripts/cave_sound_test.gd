extends Node2D

func _on_forest_scene_pressed():
	# teleports the character to another forest, to have the forest audio autoplay test for sound.
	get_tree().change_scene_to_file("res://scenes/benscene.tscn")
