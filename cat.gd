extends RigidBody2D

var jump_check : float 
var on_air: bool = false
var direction: float = 1.0 # 1 = derecha, -1 = izquierda

func _ready() -> void:
	$Attack.start(2)

func _physics_process(delta: float) -> void:
	if !on_air:
		# Multiplicamos la velocidad por la dirección
		global_position.x += (100 * direction) * delta 

func _on_attack_timeout() -> void:
	if !on_air :
		jump_check = randf_range(0.0, 1.0)
		if jump_check >= 0.5:
			# El salto ahora respeta la dirección del gato
			apply_central_impulse(Vector2(500 * direction, -500))
			on_air = true

func _on_body_entered(body: Node) -> void:
	if body == $"../../BaloonManager/ground" :
		on_air = false

func reset() -> void:
	# Anulamos cualquier inercia invisible o salto congelado
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	
	# Restauramos los puntos de aparición a la izquierda y derecha
	var spawn_points = [Vector2(-60, 432), Vector2(684, 432)]
	global_position = spawn_points.pick_random()
	
	# Determinamos la dirección y giramos el sprite
	if global_position.x < 0:
		direction = 1.0
		$AnimatedSprite2D.flip_h = false # Mira hacia la derecha
	else:
		direction = -1.0
		$AnimatedSprite2D.flip_h = true  # Invierte la imagen para mirar a la izquierda
	
	# Determinamos hacia dónde debe caminar el gato
	if global_position.x < 0:
		direction = 1.0
	else:
		direction = -1.0

func _input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		on_air = false 
		reset()
