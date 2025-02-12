extends Node2D

@onready var audio = $"forest background"
@onready var audio = $"cave background"
@onready var audio = $"wind background"

func _on_button_pressed():
	audio.play()
	
