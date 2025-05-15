extends CharacterBody2D

@onready var hitbox = $Area2D
var player = preload("res://player.tscn")
@export var lives = 5
@onready var player_lives_label = $"../../Control/PlayerLives"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.body_entered.connect(_on_body_entered)
	player_lives_label.text = "Player Lives: %s" % lives


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		lives -= 1
		player_lives_label.text = "Player Lives: %s" % lives
		queue_free()
		if lives == 0:
			body.queue_free()
