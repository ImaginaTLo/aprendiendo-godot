extends Node2D

var escena_erupcion = preload("res://game_jam/erupcion_lava.tscn")

func _ready():
	$Timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var puntos_validos = []
	for nodo in get_children():
		if nodo is Marker2D:
			puntos_validos.append(nodo)
			
	if puntos_validos.size() > 0:
		var punto_elegido = puntos_validos.pick_random()
		var nueva_erupcion = escena_erupcion.instantiate()
		nueva_erupcion.position = punto_elegido.position
		add_child(nueva_erupcion)
