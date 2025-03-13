extends Node2D
@onready var coin = preload("res://scenes/coin.tscn")
var coin_amount = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$character/Camera2D.enabled = true
	$character.level = 1
	$cave_ambience.play()
	$character/Camera2D.limit_top =0
	$character/Camera2D.limit_bottom = 1080


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$portal/Sprite2D.rotation_degrees += 0.5

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "character" and coin_amount >= 3:
		$healthbar/AnimationPlayer.play("clear_to_black")
		await get_tree().create_timer(1).timeout
		get_tree().call_deferred("change_scene_to_file", "res://scenes/forest.tscn")

func _on_coin_picked_up() -> void:
	coin_amount = $character.coins


func _on_enemy_pop(coin_position) -> void:
	var spawned_coin = coin.instantiate()
	spawned_coin.position = coin_position
	call_deferred("add_child", spawned_coin)
