extends Area2D

var enemy = preload("res://enemy.tscn")

func _ready():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	

func _on_body_entered(body):
	pass

func _on_body_exited(body):
	# kills the enemies whenever they leave the play area
	if body.is_in_group("Enemy"):
		print("Enemy Despawned")
		body.queue_free()
