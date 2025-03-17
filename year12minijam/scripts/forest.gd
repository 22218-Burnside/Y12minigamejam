extends Node2D
@onready var coin = preload("res://scenes/coin.tscn")
var coin_amount = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$character.level = 2
	$forest_ambience.play()

func _process(_delta: float) -> void:
		$portal/Sprite2D.rotation_degrees += 0.5
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "character":
		$healthbar/AnimationPlayer.play("clear_to_black")
		await get_tree().create_timer(1).timeout
		get_tree().call_deferred("change_scene_to_file", "res://scenes/clouds.tscn")

func _on_coin_picked_up() -> void:
	coin_amount = $character.coins


func _on_enemy_pop(coin_position) -> void:
	var spawned_coin = coin.instantiate()
	spawned_coin.position = coin_position
	call_deferred("add_child", spawned_coin)
