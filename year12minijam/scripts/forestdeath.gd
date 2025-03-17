extends Control
var noon_transparency = 1 
var transparency_flip = 1

func _process(_delta: float) -> void:
	$noon.modulate.a = noon_transparency * 0.01
	if noon_transparency <= 80 and transparency_flip == 1:
		noon_transparency += 0.1
	if noon_transparency > 80 and transparency_flip == 1:
		transparency_flip = -1
	if noon_transparency >= 2 and transparency_flip == -1:
		noon_transparency -= 0.1
	if noon_transparency < 2 and transparency_flip == -1:
		transparency_flip = 1

#when the button is pressed the screen is changed to the menu
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/forest.tscn")



func _on_quit_button_pressed():
	get_tree().quit()
