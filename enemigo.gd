extends Area2D

var velocidad: float = 200.0
var direccion: int = 1

func _process(delta: float) -> void:
	position.x += velocidad * direccion * delta
	var limites_pantalla = get_viewport_rect().size
	
	if position.x <= 0 or position.x >= limites_pantalla.x:
		direccion = direccion * -1
