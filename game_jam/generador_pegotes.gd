extends Node2D

var escena_pegote = preload("res://game_jam/pegote_slime.tscn")

func _ready():
	$Timer.timeout.connect(_on_timer_timeout)  

func _on_timer_timeout():
	var puntos_validos = []
	
	# 1. EL FILTRO INTELIGENTE
	for nodo in get_children():
		# Si es un marcador Y ADEMÁS no tiene hijos (está vacío)
		if nodo is Marker2D and nodo.get_child_count() == 0:
			puntos_validos.append(nodo)
			
	# 2. Si quedan puntos vacíos, elegimos uno
	if puntos_validos.size() > 0:
		var punto_elegido = puntos_validos.pick_random()
		var nuevo_pegote = escena_pegote.instantiate()
		
		# 3. Como ahora será hijo del marcador, su posición 0,0 es exactamente encima de él
		nuevo_pegote.position = Vector2.ZERO 
		
		# 4. Metemos el pegote DENTRO del marcador elegido, no suelto en el nivel
		punto_elegido.add_child(nuevo_pegote)
