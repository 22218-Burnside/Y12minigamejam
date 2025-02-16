extends Node2D
# This code is testing for audio sounds and sfx when the character/wizard interacts with things.



func _on_cave_pressed():
	# teleports the character to cave, to have the cave audio autoplay test for sound.
	get_tree().change_scene_to_file("res://scenes/cave_sound_test.tscn")
