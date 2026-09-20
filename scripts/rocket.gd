extends CharacterBody2D

@export var id: int
var is_active: bool = true;
var displacement = Vector2(-300, 0)

func _ready() -> void:
	$Sprite.play("default")
	Game.rocket_reset.connect(_reset_rocket)

func _physics_process(delta: float) -> void:
	if is_active:
		move_and_collide(displacement * delta)
	
	
	pass

func _reset_rocket(pos: Vector2) -> void:
	position = pos
	pass

func set_id(id: int) -> void:
	self.id = id
	print(id)
	pass
	
