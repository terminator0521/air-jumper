extends Node2D

const _ROCKET_SCENE = preload("res://scenes/rocket_template.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Rocket = _ROCKET_SCENE.instantiate()
	
	add_child(Rocket)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
