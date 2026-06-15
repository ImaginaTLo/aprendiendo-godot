extends Sprite2D

var velocidad: float = 400.0

func _process(delta: float) -> void:
	var direccion: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += direccion * velocidad * delta
