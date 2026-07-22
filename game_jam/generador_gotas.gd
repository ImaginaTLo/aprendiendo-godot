extends Node2D

# 1. Cargamos el "molde" de la gota en la memoria RAM
var escena_gota = preload("res://game_jam/gota_lava.tscn")

func _ready():
	# 2. Conectamos el reloj usando el Patrón Observer
	$Timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	# 3. Fabricamos una copia exacta de la gota
	var nueva_gota = escena_gota.instantiate()
	
	# 4. Calculamos una posición X aleatoria. 
	# (Asumiendo que el centro es 0. Ajusta el 400 según lo ancha que sea tu habitación)
	var x_aleatoria = randf_range(30.0, 290.0)
	
	# 5. Colocamos la gota en esa posición aleatoria (Y se queda en 0, que es el techo)
	nueva_gota.position = Vector2(x_aleatoria, 0)
	
	# 6. Metemos la gota físicamente en el nivel
	add_child(nueva_gota)
