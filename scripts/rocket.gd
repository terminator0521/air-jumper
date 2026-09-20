extends CharacterBody2D

var id
var is_active: bool = true;
var displacement = Vector2(-300, 0)

func _ready() -> void:
	$Sprite.play("default")
	Game.rocket_reset.connect(_reset_rocket)

func _physics_process(delta: float) -> void:
	if is_active:
		move_and_collide(displacement * delta)
		print(global_position)
	
	
	pass

func _reset_rocket(id, pos: Vector2) -> void:
	if id == self.id:
		global_position = pos
		print(global_position)
	pass

func set_id(id) -> void:
	self.id = id
	pass
	
