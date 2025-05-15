extends Node2D

@export var world_speed = 100
@onready var player = $player
@onready var moving_enemies = $Moving
@onready var player_lives_label = $Control/PlayerLives
@onready var enemies_label = $Control/Enemies
@onready var enemies_alive = $Moving.get_child_count()

var last_enemy_position = Vector2.ZERO
var enemy = preload("res://enemy.tscn")
var rng = RandomNumberGenerator.new()
var new_spawn_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_ticks_msec() > new_spawn_time:
		_spawn_enemies()
		
		enemies_label.text = "Enemies: %s" % moving_enemies.get_child_count()

func _spawn_enemies():
	var available_enemies = [
		enemy
	]
	
	var enemyindex = rng.randi_range(0, available_enemies.size() - 1)
	var new_enemy = available_enemies[enemyindex].instantiate()
	
	if last_enemy_position == Vector2.ZERO:
		new_enemy.position = Vector2(5, 0)
	
	else:
		
		var x = last_enemy_position.x + rng.randi_range(35, 55)
		var y = clamp(last_enemy_position.y + rng.randi_range(-150, 150), 0, 600)
		new_enemy.position = Vector2(x, y)
	
	moving_enemies.add_child(new_enemy)
	
	last_enemy_position = new_enemy.position
	new_spawn_time += world_speed
	
func _physics_process(delta: float) -> void:
	moving_enemies.position.x -= world_speed * delta
	
