extends Node2D

@export var world_speed = 100
@onready var enemy = $Moving/enemy
@onready var player = $player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
