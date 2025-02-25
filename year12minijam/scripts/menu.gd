extends Control
var noon_transparency = 1 
var transparency_flip = 1

func _ready() -> void:
	$AnimationPlayer.play("black_to_clear")
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
func _on_play_button_pressed() -> void:
	$AnimationPlayer.play("clear_to_black")
	$"Play-Button".hide()
	$"Quit-Button".hide()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/cave.tscn")

#when the button is pressed the player is kicked out
func _on_quit_button_pressed() -> void:
	get_tree().quit()
