extends Node2D

@onready var main = get_tree().get_root().get_node('main')
@onready var projectile = load("res://basic_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot()

func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	main.add_child.call_deferred(instance)
