extends Node2D

const _ROCKET_SCENE = preload("res://objects/rocket_template.tscn")
var _rockets: Array[Node2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in range(3):
		# 1. Spawn template
		var rocket_instance = _ROCKET_SCENE.instantiate()
		
		# 3. Add just the CharacterBody2D to your reference array
		_rockets.append(rocket_instance)
		
		# 4. Position the node (or you can position rocket_instance)
		rocket_instance.position.y = 0 + (60 * i)
		
		# 5. Add the ENTIRE scene structure to your game tree
		add_child(rocket_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
