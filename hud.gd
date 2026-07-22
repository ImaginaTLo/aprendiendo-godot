extends CanvasLayer

var puntos = 0

func _ready():
	$TimerPuntos.timeout.connect(_on_timer_puntos_timeout)

func _on_timer_puntos_timeout():
	puntos += 1
	# str() convierte el número a texto para poder juntarlo con la palabra
	$Label.text = "Tiempo: " + str(puntos)
