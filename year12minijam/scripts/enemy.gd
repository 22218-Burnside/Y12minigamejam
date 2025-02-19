extends Node2D

signal squished
signal hit_player
var speed = 0.001
var damage = 0
var health = 3
var can_kill = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#If health is below 1 enemy is removed
	if health < 1:
		can_kill = false
		queue_free()
	$Path2D/PathFollow2D.progress_ratio += speed


func _on_squish_hitbox_area_entered(area: Area2D) -> void:
	#Checks if it's player, takes squish power and applies damage
	if area.name == "player_squish":
		damage = get_parent().get_node("forest/character").squish_power
		health -= damage
		damage = 0
		squished.emit()
		

func _on_kill_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "character" and can_kill:
		hit_player.emit()
		can_kill = false
		$kill_timer.start()


func _on_kill_timer_timeout() -> void:
	can_kill = true
