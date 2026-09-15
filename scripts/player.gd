extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var h_direction: float

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
	
	# move
	velocity.x = h_direction * SPEED
	move_and_slide()
	pass
