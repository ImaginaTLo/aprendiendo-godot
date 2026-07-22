extends Node2D

var escena_pegote = preload("res://game_jam/pegote_slime.tscn")

func _ready():
	$Timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	
	print("El reloj ha sonado. Intentando crear pegote...")
	# 1. Creamos una lista vacía para guardar nuestros puntos
	var puntos_validos = []
	
	# 2. Revisamos todos los hijos de este generador
	for nodo in get_children():
		if nodo is Marker2D: # Si es un marcador, lo añadimos a la lista
			puntos_validos.append(nodo)
			
	# 3. Si hay puntos válidos, elegimos uno al azar
	if puntos_validos.size() > 0:
		var punto_elegido = puntos_validos.pick_random()
		
		# 4. Fabricamos el pegote y lo ponemos en esa posición
		var nuevo_pegote = escena_pegote.instantiate()
		nuevo_pegote.position = punto_elegido.position
		add_child(nuevo_pegote)
