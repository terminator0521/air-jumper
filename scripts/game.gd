extends Node2D

var score = 0
signal rocket_reset(id, pos: Vector2)
signal rocket_offscreen(id)
signal shoot(pos: Vector2, dir: Vector2)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
