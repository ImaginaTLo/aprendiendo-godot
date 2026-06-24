extends Node2D

var molde_enemigo = preload("res://enemigo.tscn")

func _on_timer_timeout() -> void:
	var nuevo_clon = molde_enemigo.instantiate()
	var altura_aleatoria = randf_range(50.0, 600.0)
	nuevo_clon.position = Vector2(10, altura_aleatoria)
	add_child(nuevo_clon)
