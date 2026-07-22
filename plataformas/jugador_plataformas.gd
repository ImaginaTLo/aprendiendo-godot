extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
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
