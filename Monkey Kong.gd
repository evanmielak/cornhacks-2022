extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite
var velocity = Vector2()

func _ready():
	_animated_sprite.play("idle")
	$CollisionShape2d.disabled = false
	


func _on_KillsPlayer_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene("res://scenes/Main_4.tscn")
	

func _on_DeathBox_body_entered(body):
	if body.is_in_group("Player"):
		_animated_sprite.play("Death")
		$CollisionShape2d.disabled = true
		velocity.y += 20
