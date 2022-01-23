extends KinematicBody2D

export (int) var speed = 100
export (int) var jump_speed = -300
export (int) var gravity = 1000
export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
var dir
var wall_direction = 1
var jump_remaining = true
onready var _animated_sprite = $Sprite
onready var left_wall_raycasts = $WallRaycasts/LeftWallCasts
onready var right_wall_raycasts = $WallRaycasts/RightWallCasts




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
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump_remaining = true
			velocity.y = jump_speed
		elif jump_remaining:
			for raycast in left_wall_raycasts.get_children():
				print(raycast.is_colliding())
				if raycast.is_colliding(): 
					velocity.y = jump_speed
					jump_remaining = false
					return
			for raycast in right_wall_raycasts.get_children():
				print(raycast.is_colliding())
				if raycast.is_colliding():
					velocity.y = jump_speed
					jump_remaining = false
					return
#			_update_wall_direction()
#			if dir != -wall_direction:
#				dir = -wall_direction
				
	if velocity.y != 0:
		_animated_sprite.play("Jump")

func _update_wall_direction():
	var is_near_wall_left = _check_is_valid_wall(left_wall_raycasts)
	var is_near_wall_right = _check_is_valid_wall(right_wall_raycasts)
	
	if is_near_wall_left && is_near_wall_right:
		wall_direction = dir
	else:
		wall_direction = -int(is_near_wall_left) + int(is_near_wall_right)


func _check_is_valid_wall(wall_raycasts):
	for raycast in wall_raycasts.get_children():
		print(raycast)
		if raycast.is_colliding():
			return true
	return false
				
