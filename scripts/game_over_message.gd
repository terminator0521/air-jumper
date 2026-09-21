extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Message.add_theme_font_size_override("font_size", 48)
	$Message.text = "GAME OVER\nSCORE: " + str(Game.score)
	Game.score = 0
	pass # Replace with function body.


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	pass # Replace with function body.
