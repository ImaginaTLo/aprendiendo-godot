extends Area2D

func _ready():
	print("La lava está lista y esperando...")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Esto imprimirá en la consola el nombre de CUALQUIER cosa que toque la lava
	print("La lava ha tocado a: ", body.name) 
	
	if body.is_in_group("jugador"):
		if body.is_squashed == false:
			print("¡El Slime se ha derretido!")
			body.morir()
		else:
			print("El Slime resistió la lava gracias a su habilidad.")
