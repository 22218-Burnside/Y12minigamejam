extends Node2D
@onready var coin = preload("res://scenes/coin.tscn")
var coin_amount = 0

func _ready() -> void:
	$character.level = 3
	$character/Camera2D.limit_top = -30
	$character/Camera2D.limit_bottom = 1100
	# This gives the animation to the clouds behind the player
	$parallax_back/layer1/layer1.play("default")
	$parallax_back/layer2/layer2.play("default")
	$parallax_back/layer3/layer3.play("default")
	$parallax_back/layer5/layer5.play("default")
	$parallax_back/layer7/layer7.play("default")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "character":
		$healthbar/AnimationPlayer.play("clear_to_black")
		await get_tree().create_timer(1).timeout
		get_tree().call_deferred("change_scene_to_file", "res://scenes/winnerscreen.tscn")

func _on_coin_picked_up() -> void:
	coin_amount = $character.coins


func _on_enemy_pop(coin_position) -> void:
	var spawned_coin = coin.instantiate()
	spawned_coin.position = coin_position
	call_deferred("add_child", spawned_coin)
