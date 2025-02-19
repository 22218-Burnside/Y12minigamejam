extends Control


#when the button is pressed the screen is changed to the menu
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
