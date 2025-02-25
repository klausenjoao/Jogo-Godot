extends CharacterBody2D

var speed = 300.0
var jump_speed = -500.0

# Pega a gravidade das configurações do projeto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Aplica a gravidade apenas quando o personagem não está no chão
	if not is_on_floor():
		velocity.y += gravity * delta

	# Lógica de pulo
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		$SoundJump.play()
		velocity.y = jump_speed  # Aqui o pulo ocorre corretamente

	# Obtém a direção do input
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	# Lógica de animação
	if direction != 0:
		$AnimatedSprite2D.flip_h = direction < 0
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	# Aplica o movimento
	move_and_slide()
