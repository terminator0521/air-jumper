extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# right to left movement
	if Input.is_key_pressed(KEY_LEFT):
		position.x -= SPEED * delta
		$AnimatedSprite2D.flip_h = 1
		$AnimatedSprite2D.play("walking")
	elif Input.is_key_pressed(KEY_RIGHT):
		$AnimatedSprite2D.flip_h = 0
		$AnimatedSprite2D.play("walking")
		position.x += SPEED * delta
	else:
		$AnimatedSprite2D.play("default")

	pass
