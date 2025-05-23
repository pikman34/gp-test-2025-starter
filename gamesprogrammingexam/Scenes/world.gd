extends Node2D

@export var world_speed = 100
@onready var player = $player
@onready var moving_enemies = $Moving
@onready var player_lives_label = $Control/PlayerLives
@onready var enemies_label = $Control/Enemies
@onready var enemies_alive = $Moving.get_child_count()
@onready var lives = 5

var last_enemy_position = Vector2.ZERO
var enemy = preload("res://enemy.tscn")
var rng = RandomNumberGenerator.new()
var new_spawn_time = 0
var active = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# checks if the ticks are greater than the spawn time then spawns an enemy
	if Time.get_ticks_msec() > new_spawn_time:
		_spawn_enemies()
		
		enemies_label.text = "Enemies: %s" % moving_enemies.get_child_count()

func _spawn_enemies():
	if (active == true):
		var available_enemies = [
			enemy
		]
		
		#enemey spawn handler, finds a new position for enemy and spawns it
		var enemyindex = rng.randi_range(0, available_enemies.size() - 1)
		var new_enemy = available_enemies[enemyindex].instantiate()
		
		if last_enemy_position == Vector2.ZERO:
			new_enemy.position = Vector2(5, 0)
		
		else:
			#giving the enemy new position to spawn in
			var x = last_enemy_position.x + rng.randi_range(35, 55)
			var y = clamp(last_enemy_position.y + rng.randi_range(-300, 300), 0, 600)
			new_enemy.position = Vector2(x, y)
		
		moving_enemies.add_child(new_enemy)
		
		#sets the enemy's last position to its new spot
		last_enemy_position = new_enemy.position
		new_spawn_time += world_speed
	
func _physics_process(delta: float) -> void:
	#causes the enemies to move as they spawn
	moving_enemies.position.x -= world_speed * delta
	
