extends Control

#when the button is pressed the screen is changed to the starter level
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/cave.tscn")

#when the button is pressed the player is kicked out
func _on_quit_button_pressed() -> void:
	get_tree().quit()
