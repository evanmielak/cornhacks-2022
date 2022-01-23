extends KinematicBody2D

export (int) var speed = 100
export (int) var jump_speed = -300
export (int) var gravity = 1000
export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
var dir
var jump_remaining = true
onready var _animated_sprite = $Sprite



func get_input():
	dir = 0
	if Input.is_action_pressed("move_right"):
		$Sprite.flip_h = true
		_animated_sprite.play("RunningRight")
		dir += 1
	if Input.is_action_pressed("move_left"):
		$Sprite.flip_h = false
		_animated_sprite.play("RunningLeft")
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		_animated_sprite.play("Idle")
	if Input.is_action_pressed("next_level"):
		print("res://scenes/Main_" + str(int(get_tree().current_scene.name) + 1))
		get_tree().change_scene("res://scenes/Main_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		jump_remaining = true
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_speed
	else:
		if Input.is_action_just_pressed("jump"):
			if jump_remaining:
				velocity.y = jump_speed
				jump_remaining = false
	if velocity.y != 0:
		_animated_sprite.play("Jump")
				
