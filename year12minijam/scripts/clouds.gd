extends Node2D

func _ready() -> void:
	$character/Camera2D.limit_top = -30
	$character/Camera2D.limit_bottom = 1100
	# This gives the animation to the clouds behind the player
	$parallax_back/layer1/layer1.play("default")
	$parallax_back/layer2/layer2.play("default")
	$parallax_back/layer3/layer3.play("default")
	$parallax_back/layer5/layer5.play("default")
	$parallax_back/layer7/layer7.play("default")
	#This gives the animation to the clouds in front of the player
	$parallax_front/layer4/layer4.play("default")
	$parallax_front/layer6/layer6.play("default")
	
	
