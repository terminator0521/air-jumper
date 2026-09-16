extends CharacterBody2D

var is_jumping = false
var is_falling = true
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
	if is_falling:
		displacement.y = FALL_SPEED * delta
	else:
		displacement.y = 0;
	
	# Apply movement
	var collide = move_and_collide(displacement)
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area != null:
		if area.is_in_group("Platform"):
			is_falling = false
			
			
	pass # Replace with function body.
