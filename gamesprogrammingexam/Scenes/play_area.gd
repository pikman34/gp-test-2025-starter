extends Area2D

var enemy = preload("res://enemy.tscn")

func _ready():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.set_active(true)

func _on_body_exited(body):
	if body.is_in_group("Enemy"):
		body.queue_free()
