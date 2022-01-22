extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -600
export (int) var gravity = 1000
export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
onready var _animated_sprite = $Sprite

func get_input():
	var dir = 0
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

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
			
	if velocity.y != 0:
		_animated_sprite.play("Jump")
