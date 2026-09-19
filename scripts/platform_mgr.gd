extends Node2D

@export var _start_despawn_time = 3
var _despawn_timer = 0



var _start_platform
const _ROCKET_SCENE = preload("res://objects/rocket_template.tscn")
const _SPAWN_POS: Array[Array] = [
	[-250, 250, 167, -167],
	[4, 5, 6],
	[7, 8, 9],
]
var _rockets: Array[Node2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		# 1. Spawn template
	_start_platform = _ROCKET_SCENE.instantiate()
		# 5. Add the ENTIRE scene structure to your game tree
	add_child(_start_platform)


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

func _spawn_next() -> void:
	pass
