extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _collided(other_area: Area2D) -> void:
	SignalBus.on_area_entered.emit(self, other_area)
	
