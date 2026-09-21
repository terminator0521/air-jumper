extends CharacterBody2D

var dir: Vector2
var shooting: bool = false

func _ready() -> void:
	Game.shoot.connect(_shoot)

func _physics_process(delta: float) -> void:
	if shooting:
		move_and_collide(dir * delta)
	
	

func _shoot(pos: Vector2, dir: Vector2) -> void:
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
	shooting = false
	hide()
	
func _enable_bullet() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	shooting = true
	show()


func _on_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Platform") && shooting:
		_disable_bullet()
		var id = area.get_parent().id
		if id != null:
			Game.rocket_offscreen.emit(id)
	pass # Replace with function body.
