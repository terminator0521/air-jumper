extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Exit.pressed.connect(_on_exit_pressed)
	$Play.pressed.connect(_on_play_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_exit_pressed() -> void:
	get_tree().quit(0)
	pass
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	pass
