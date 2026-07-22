extends Node2D

var escena_salpicadura = preload("res://game_jam/salpicadura_lava.tscn")

func _ready():
	$Timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var nueva_salpicadura = escena_salpicadura.instantiate()
	var x_aleatoria = randf_range(30, 290.0)
	nueva_salpicadura.position = Vector2(x_aleatoria, 0)
	add_child(nueva_salpicadura)
