extends Area2D

var velocidad = 100.0 # Velocidad constante
var altura_maxima = 70.0 # Píxeles que viaja hacia arriba (ajústalo a tu gusto)
var y_inicial = 0.0
var subiendo = true

func _ready():
	y_inicial = position.y # Guardamos de dónde salió
	body_entered.connect(_on_body_entered)

func _process(delta):
	if subiendo:
		position.y -= velocidad * delta # Sube
		# Si la distancia recorrida es mayor que la altura máxima, cambiamos de dirección
		if y_inicial - position.y >= altura_maxima:
			subiendo = false
	else:
		position.y += velocidad * delta # Baja

func _on_body_entered(body):
	if body.is_in_group("jugador"):
		if body.is_squashed == false:
			print("¡Una salpicadura te ha calcinado!")
			get_tree().call_deferred("reload_current_scene")
		else:
			queue_free()
	elif not body.is_in_group("jugador"):
		queue_free() # Se destruye al volver a caer a la lava
