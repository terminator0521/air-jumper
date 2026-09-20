extends Node2D

@export var _start_despawn_time: float = 3
var _despawn_timer: float = 0

const h_platform_offset = 250
var _start_platform
const _ROCKET_SCENE = preload("res://objects/rocket_template.tscn")
const _start_x = 400
const _SPAWN_POS_Y: Array = [
	-150,
	70,
	127,
	-137,
	-53,
	123,
	-113,
	86,
	137,
	123,
	-127,
	120
]
const _SPAWN_POS_X: Array = [
	_start_x - 160,
	_start_x - 120,
	_start_x - 40,
	_start_x - 80,
	_start_x
]
var _rockets: Array[Node2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.rocket_offscreen.connect(_reset_rocket)
		# Spawn template
	_start_platform = _ROCKET_SCENE.instantiate()
		# Add the scene
	add_child(_start_platform)
	
	# all rockets
	for i in range(9):
		var platforms = _ROCKET_SCENE.instantiate()
		platforms.set_id(i)
		add_child(platforms)
		_reset_rocket(i)
	
	for i in range(3): # waves of rockets
		for j in range(3 * i, 3 * i + 3): # rockets per wave
			Game.rocket_reset.emit(j, Vector2(_SPAWN_POS_X.pick_random() + (h_platform_offset * i), _SPAWN_POS_Y[j]))

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
			
	
	

func _reset_rocket(id) -> void:
	
	var new_y
	var new_pos = Vector2(_SPAWN_POS_X.pick_random(), _SPAWN_POS_Y[id])
	
	Game.rocket_reset.emit(id, new_pos)
	pass
