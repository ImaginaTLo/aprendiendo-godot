extends Area2D


func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.is_in_group("jugador"):
		print("¡Moneda recogida por el jugador!")
		queue_free()
