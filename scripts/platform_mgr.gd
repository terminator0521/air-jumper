extends Node2D

@export var _start_despawn_time: float = 3
var _despawn_timer: float = 0

var _start_platform
const _ROCKET_SCENE = preload("res://objects/rocket_template.tscn")
const _start_x = 400
const _SPAWN_POS_Y: Array[Vector2] = [
	Vector2(-250, _start_x),
	Vector2(250, _start_x),
	Vector2(167, _start_x),
	Vector2(-167, _start_x),
	Vector2(-233, _start_x),
	Vector2(123, _start_x),
	Vector2(-153, _start_x),
	Vector2(256, _start_x),
	Vector2(277, _start_x),
	Vector2(123, _start_x),
	Vector2(-297, _start_x),
	Vector2(-177, _start_x)
]
var _rockets: Array[Node2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.rocket_offscreen.connect(_reset_rocket)
		# Spawn template
	_start_platform = _ROCKET_SCENE.instantiate()
		# Add the scene
	add_child(_start_platform)
	
	for i in range(3):
		var platforms = _ROCKET_SCENE.instantiate()
		platforms.set_id(i)
		add_child(platforms)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if _start_platform != null:
		if _despawn_timer < _start_despawn_time * (1 / delta):
			_despawn_timer += 1
		else:
			_start_platform.queue_free()
			_start_platform = null
			
	
	

func _reset_rocket() -> void:
	var new_pos = _SPAWN_POS_Y.pick_random()
	
	Game.rocket_reset.emit(new_pos)
	pass
