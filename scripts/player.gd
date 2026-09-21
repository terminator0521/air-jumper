extends CharacterBody2D

var is_jumping = false
var is_grounded = false
var platform_velocity
var displacement: Vector2
var direction: Vector2
var falling_speed: float = 20
const SPEED = 300
const BULLET_SPEED = 500
const JUMP_VELOCITY = -600
const MAX_FALL_SPEED = 400
var last_dir: float

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	print(is_jumping)
	if direction.x != 0:
		$AnimatedSprite2D.flip_h = (direction.x < 0)
	if is_grounded:
		match direction:
			Vector2(1, 0), Vector2(-1, 0):
				if $AnimatedSprite2D.animation != "forward":
					$AnimatedSprite2D.play("forward")
			Vector2.ZERO, Vector2(0, -1):
				if $AnimatedSprite2D.animation != "idle":
					$AnimatedSprite2D.play("idle")
			Vector2(0, 1):
				if $AnimatedSprite2D.animation != "up":
					$AnimatedSprite2D.play("up")
			Vector2(1, 1), Vector2(-1, 1):
				if $AnimatedSprite2D.animation != "d_up":
					$AnimatedSprite2D.play("d_up")
			Vector2(1, -1), Vector2(-1, -1):
				if $AnimatedSprite2D.animation != "d_down":
					$AnimatedSprite2D.play("d_down")
	else:
		if $AnimatedSprite2D.animation != "in_air":
			$AnimatedSprite2D.play("in_air")

func _physics_process(delta: float) -> void:
	# right to left direction
	if Input.is_key_pressed(KEY_LEFT):
		direction.x = -1
		last_dir = -1
	elif Input.is_key_pressed(KEY_RIGHT):
		last_dir = 1
		direction.x = 1
	else:
		direction.x = 0
		
	# up and down direction
	if Input.is_key_pressed(KEY_UP):
		direction.y = 1
	elif Input.is_key_pressed(KEY_DOWN):
		direction.y = -1
	else:
		direction.y = 0
	
	displacement.x = direction.x * SPEED
	
	# Gravity and jump
	if is_grounded:
		displacement.x += -100
		if Input.is_action_just_pressed("jump") and !is_jumping:
			if Input.is_action_pressed("down") and direction.x == 0:
				is_grounded = false
			else:
				is_jumping = true
				is_grounded = false
		else:
			displacement.y = 0
	elif is_jumping:
		is_jumping = false
		displacement.y = JUMP_VELOCITY
	elif displacement.y < MAX_FALL_SPEED:
		displacement.y += falling_speed
	
	# Shoot
	if Input.is_action_just_pressed("shoot"):
		var input_dir: Vector2
		
		
		if direction.y == 1 and direction.x == 0:
			input_dir.x = 0
		else:
			input_dir.x = last_dir
			
		if direction.y == -1 and direction.x == 0:
			if !is_grounded:
				input_dir.y = 1
				input_dir.x = 0
			else:
				input_dir.y = 0
		else:
			input_dir.y = -direction.y
		
		input_dir = input_dir.normalized()
		input_dir *= BULLET_SPEED
		Game.shoot.emit(position, input_dir)
	
	# Apply movement
	var collide = move_and_collide(displacement * delta)
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Platform"):
		if $Area2D.global_position.y + _get_extents($Area2D).y - falling_speed < area.global_position.y - _get_extents(area).y:
			is_grounded = true
			pass


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Platform"):
		is_grounded = false
	pass # Replace with function body.
	
func _get_extents(area: Node2D) -> Vector2:
	var owner = area.get_shape_owners()
	var other_shape = area.shape_owner_get_shape(owner[0], 0)
	if other_shape:
		var extents = other_shape.get("extents")
		if extents is Vector2:
			return extents * area.global_scale
	return Vector2.ZERO


func _on_bounds_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		get_tree().change_scene_to_file("res://scenes/game_end.tscn")
	pass
	pass # Replace with function body.
