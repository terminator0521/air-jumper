extends CharacterBody2D

var is_jumping = false
var is_grounded = false
var platform_velocity
var displacement: Vector2
var h_direction: float
var falling_speed: float = 10

const SPEED = 300
const JUMP_VELOCITY = -400
const MAX_FALL_SPEED = 10

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if h_direction != 0:
		$AnimatedSprite2D.flip_h = (h_direction < 0)

	match h_direction:
		1.0, -1.0:
			if $AnimatedSprite2D.animation != "walking":
				$AnimatedSprite2D.play("walking")
		0.0:
			if $AnimatedSprite2D.animation != "default":
				$AnimatedSprite2D.play("default")
	pass

func _physics_process(delta: float) -> void:
	print(displacement.y)	
	
	# right to left direction
	if Input.is_key_pressed(KEY_LEFT):
		h_direction = -1
	elif Input.is_key_pressed(KEY_RIGHT):
		h_direction = 1
	else:
		h_direction = 0
	
	displacement.x = h_direction * SPEED * delta
	
	# Gravity and jump
	if is_grounded:
		if Input.is_action_just_pressed("jump") and !is_jumping:
			is_jumping = true
			is_grounded = false
		else:
			displacement.y = 0
	elif is_jumping:
		is_jumping = false
		displacement.y = JUMP_VELOCITY * delta
	elif displacement.y < MAX_FALL_SPEED:
		displacement.y += falling_speed * delta
	
	# Apply movement
	var collide = move_and_collide(displacement)
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Platform"):
		if $Area2D.global_position.y + _get_extents($Area2D).y - 4 < area.global_position.y - _get_extents(area).y:
			is_grounded = true
			#$Area2D.global_position.y = area.global_position.y - _get_extents(area).y - _get_extents($Area2D).y
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
