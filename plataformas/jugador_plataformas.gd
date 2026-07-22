extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
const SPEED = 80.0
const JUMP_VELOCITY = -250.0
const SQUASH_DURATION = 1.7 # Segundos de invulnerabilidad
var is_squashed = false # Estado de aplastamiento
var squash_timer = 0.0 # Cronómetro
var municion_slime = 0
const MAX_MUNICION = 4 # El máximo de secciones que dijiste en el GDD

func _physics_process(delta):
	
	# BOTÓN DE REINICIO MANUAL
	if Input.is_action_just_pressed("reiniciar"):
		get_tree().reload_current_scene()
		
	# --- ESTADO 1: APLASTADO (INVULNERABLE) ---
	if is_squashed:
		squash_timer -= delta
		if squash_timer <= 0:
			# Se acaba el efecto: volvemos a la normalidad
			is_squashed = false
			anim.scale = Vector2(1, 1) # Restauramos el tamaño visual
			anim.position.y = 0 # Devolvemos el dibujo a su centro original
		else:
			# Mientras estamos aplastados:
			velocity.x = 0 # No podemos movernos a los lados
			if not is_on_floor():
				velocity += get_gravity() * delta # La gravedad sigue afectando por si caemos
			move_and_slide()
			return # Ignoramos el resto del código de movimiento

	# --- ESTADO 2: NORMAL ---
	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Salto Normal y Variable
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("saltar") and velocity.y < 0:
		velocity.y *= 0.5

	# ACTIVAR HABILIDAD (Solo si estamos en el suelo, no aplastados, Y TENEMOS MUNICIÓN)
	if Input.is_action_just_pressed("habilidad") and is_on_floor() and not is_squashed and municion_slime > 0:
		municion_slime -= 1 # Gastamos una carga
		print("Habilidad usada. Munición restante: ", municion_slime)
		is_squashed = true
		squash_timer = SQUASH_DURATION
		anim.scale = Vector2(1.8, 0.3) # 1.8 de ancho, 0.3 de alto (más fino)
		anim.position.y = 10 # Empujamos el dibujo 11 píxeles hacia abajo para que toque el suelo

	# Movimiento Horizontal
	var direction = Input.get_axis("mover_izq", "mover_der")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# DIRECCIÓN Y ANIMACIÓN
	if direction != 0:
	# Si nos movemos, reproducir correr
		anim.play("run")
	# Girar el sprite dependiendo de si vamos a izquierda o derecha
		if direction < 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
	else:
	# Si estamos quietos, reproducir idle
		anim.play("idle")
	
# EL SALTO TIENE PRIORIDAD
	if not is_on_floor():
	# Si no estamos en el suelo, reproducir salto (sobrescribe lo anterior)
		anim.play("jump")

	move_and_slide()
	
func recoger_pegote():
	if municion_slime < MAX_MUNICION:
		municion_slime += 1
		print("Munición actual: ", municion_slime)
