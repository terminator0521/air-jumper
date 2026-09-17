extends CharacterBody2D

var is_jumping = false
var is_grounded = false
var platform_velocity
var displacement: Vector2
var h_direction: float

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FALL_SPEED = 250.0

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
	
	# right to left direction
	if Input.is_key_pressed(KEY_LEFT):
		h_direction = -1
	elif Input.is_key_pressed(KEY_RIGHT):
		h_direction = 1
	else:
		h_direction = 0
	
	displacement.x = h_direction * SPEED * delta
	
	# Gravity
	if is_grounded:
		displacement.y = 0;
	else:
		displacement.y = FALL_SPEED * delta
	
	# Apply movement
	var collide = move_and_collide(displacement)
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Platform"):
		if $Area2D.global_position.y + _get_extents($Area2D).y - 4 < area.global_position.y - _get_extents(area).y:
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
