extends Area2D

@onready var aviso = $Aviso
@onready var pilar = $Pilar
@onready var colision = $CollisionShape2D
@onready var timer = $Timer

var fase = 0
# Guardamos dónde deben estar el pilar y la colisión cuando están subidos
var pilar_y_original = 0.0
var colision_y_original = 0.0

func _ready():
	body_entered.connect(_on_body_entered)
	timer.timeout.connect(_on_timer_timeout)
	
	# 1. Guardamos sus posiciones correctas
	pilar_y_original = pilar.position.y
	colision_y_original = colision.position.y
	
	# 2. Los ESCONDEMOS empujándolos 600 píxeles hacia abajo (bajo tierra)
	pilar.position.y += 600
	colision.position.y += 600
	
	# 3. Configuramos la Fase 0 (Aviso)
	aviso.visible = true
	pilar.visible = true # Ahora es visible, pero está escondido bajo tierra
	colision.set_deferred("disabled", true) 
	
	timer.start(1.5)

func _on_timer_timeout():
	if fase == 0:
		# FASE 1: ¡Erupción Animada!
		fase = 1
		aviso.visible = false
		colision.set_deferred("disabled", false)
		
		# CREAMOS EL TWEEN (Animador)
		var tween = create_tween()
		tween.set_parallel(true) # Hace que el pilar y la colisión suban a la vez
		
		# Le decimos: "Mueve la position:y del pilar, hasta su posición original, en 0.2 segundos"
		tween.tween_property(pilar, "position:y", pilar_y_original, 0.2)
		tween.tween_property(colision, "position:y", colision_y_original, 0.2)
		
		timer.start(1.0)
	else:
		# FASE 2: Fin
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("jugador"):
		if body.is_squashed == false:
			print("¡Una erupción te ha desintegrado!")
			body.morir()
