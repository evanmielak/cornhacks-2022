extends KinematicBody2D

var velocity = Vector2()
export var direction = -1

func _ready():
	if direction == 1:
		$AnimatedSprite.filp_h = true

func _physics_process(delta):
	if is_on_wall():
		direction = direction * -1
		#if $AnimatedSprite.flip_h == true:
			#$AnimatedSprite.flip_h = false
		#if $AnimatedSprite.flip_h == false:
			#$AnimatedSprite.flip_h = true
		
	velocity.x = 50 * direction
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene("res://scenes/Main_2.tscn")
		Global.dots = 140
		
