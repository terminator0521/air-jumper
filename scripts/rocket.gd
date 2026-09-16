extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var displacement: Vector2

func _ready() -> void:
    position = Vector2(0, 0)

func _physics_process(delta: float) -> void:
    move_and_collide(displacement)
