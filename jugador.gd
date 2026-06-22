extends Sprite2D

var velocidad: float = 400.0

func _process(delta: float) -> void:
	var direccion: Vector2 = Input.get_vector("mover_izq", "mover_der", "mover_arriba", "mover_abajo")
	position += direccion * velocidad * delta
	var limites_pantalla = get_viewport_rect().size
	position.x = clamp(position.x, 0, limites_pantalla.x)
	position.y = clamp(position.y, 0, limites_pantalla.y)
