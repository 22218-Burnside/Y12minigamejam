extends Control


#when the button is pressed the screen is changed to the menu
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/forest.tscn")



func _on_quit_button_pressed():
	get_tree().quit()
