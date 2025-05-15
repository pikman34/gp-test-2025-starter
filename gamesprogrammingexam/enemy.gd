extends CharacterBody2D

@onready var world = $"../.."
@onready var hitbox = $Area2D
@onready var player = $"../../player"
@onready var player_lives_label = $"../../Control/PlayerLives"
@onready var you_survived_enemies_label = $"../../DeathUI/YouSurvivedText"
@onready var game_over_UI = $"../../DeathUI"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.body_entered.connect(_on_body_entered)
	player_lives_label.text = "Player Lives: %s" % world.lives


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		world.lives -= 1
		player_lives_label.text = "Player Lives: %s" % world.lives
		queue_free()
		if world.lives == 0:
			body.queue_free()
			world.active = false
			you_survived_enemies_label.text = "You survived %s Enemies!" % world.moving_enemies.get_child_count()
			game_over_UI.set_visible(true)
