extends Sprite2D

var velocidad_caminar: float = 400.0
var velocidad_sprint: float = 800.0
var velocidad_actual: float = 400.0

var puntuacion: int = 0
var meta_monedas: int = 10

var juego_terminado: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reiniciar"):
		get_tree().reload_current_scene()
		
	if juego_terminado == true:
		return

	if Input.is_action_pressed ("sprint"):
		velocidad_actual = velocidad_sprint
	else:
		velocidad_actual = velocidad_caminar
		
	var direccion: Vector2 = Input.get_vector("mover_izq", "mover_der", "mover_arriba", "mover_abajo")
	position += direccion * velocidad_actual * delta
	
	var limites_pantalla = get_viewport_rect().size
	position.x = clamp(position.x, 0, limites_pantalla.x)
	position.y = clamp(position.y, 0, limites_pantalla.y)


func _on_detector_area_entered(area: Area2D) -> void:
	
	if juego_terminado == true:
		return
	
	var marcador_ui = get_node("../Marcador")
	
	if area.is_in_group("monedas"):
		area.queue_free()
		$SonidoMoneda.play()
		puntuacion += 1
	
		if puntuacion == meta_monedas:
			marcador_ui.text = "!HAS GANADO! Pulsa `R`"
			juego_terminado = true
		else:
			marcador_ui.text = "Puntos: " + str(puntuacion)
		
	elif area.is_in_group("enemigos"):
		marcador_ui.text = "!HAS MUERTO! Pulsa `R`"
		visible = false
		juego_terminado = true
