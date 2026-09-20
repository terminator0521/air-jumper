extends CharacterBody2D

var dir: float
var shooting: bool = false
const SPEED = 500.0

func _ready() -> void:
	Game.shoot.connect(_shoot)

func _physics_process(delta: float) -> void:
	if shooting:
		move_and_collide(Vector2(SPEED * dir, 0) * delta)
	
	

func _shoot(pos: Vector2, dir: float) -> void:
	if !shooting:
		position = pos
		self.dir = dir
		_enable_bullet()


func _on_bounds_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		_disable_bullet()
	pass # Replace with function body.

func _disable_bullet() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	$CollisionShape2D.disabled = true
	shooting = false
	hide()
	
func _enable_bullet() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	$CollisionShape2D.disabled = false
	shooting = true
	show()
