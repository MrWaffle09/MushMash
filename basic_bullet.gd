extends CharacterBody2D

var pos:Vector2
var rota:float
var dir:float
var speed = 1500

func _ready():
	global_position = pos
	global_rotation = rota
