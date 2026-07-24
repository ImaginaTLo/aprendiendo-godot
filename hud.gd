extends CanvasLayer

var puntos = 0

func _ready():
	$TimerPuntos.timeout.connect(_on_timer_puntos_timeout)
	var jugador = get_tree().get_first_node_in_group("jugador")
	if jugador != null:
		jugador.municion_cambiada.connect(_on_jugador_municion_cambiada)
		jugador.puntuacion_cambiada.connect(_on_jugador_puntuacion_cambiada)
		# Nos suscribimos a la muerte
		jugador.ha_muerto.connect(_on_jugador_muerto)

func _on_timer_puntos_timeout():
	puntos += 1
	$Label.text = "Time: " + str(puntos) 

func _on_jugador_municion_cambiada(nueva_cantidad):
	$ProgressBar.value = nueva_cantidad
	
	# 1. Obtenemos el estilo actual y lo DUPLICAMOS (para no perder tus bordes dorados)
	var estilo_relleno = $ProgressBar.get_theme_stylebox("fill").duplicate()
	
	# 2. Cambiamos SOLO el color de fondo de esa copia
	if nueva_cantidad == 4:
		estilo_relleno.bg_color = Color.YELLOW
	else:
		estilo_relleno.bg_color = Color.GREEN
		
	# 3. Aplicamos la copia modificada a la barra
	$ProgressBar.add_theme_stylebox_override("fill", estilo_relleno)

# 4. Función para actualizar el texto de los pegotes
func _on_jugador_puntuacion_cambiada(nueva_puntuacion):
	$LabelPuntuacion.text = "Score: " + str(nueva_puntuacion)
	
func _on_jugador_muerto():
	$TimerPuntos.stop() # Paramos de sumar tiempo
	$LabelGameOver.visible = true # Mostramos el mensaje
