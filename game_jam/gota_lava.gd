extends Area2D

const FALL_SPEED = 100.0 # Velocidad de caída

func _ready():
	# Conectamos la señal de colisión
	body_entered.connect(_on_body_entered)

func _process(delta):
	# Hacemos que la gota caiga hacia abajo (Y positivo es hacia abajo en 2D)
	position.y += FALL_SPEED * delta

func _on_body_entered(body):
	# Si toca al jugador...
	if body.is_in_group("jugador"):
		if body.is_squashed == false:
			print("¡Una gota ha derretido al Slime!")
			get_tree().call_deferred("reload_current_scene")
		else:
			print("La gota rebotó en el Slime aplastado.")
			queue_free() # La gota se destruye al chocar contra el escudo
			
	# Si toca el suelo o la lava del fondo (asumiendo que no son el jugador)...
	elif not body.is_in_group("jugador"):
		queue_free() # La gota se destruye para no consumir memoria infinita
