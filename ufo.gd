class_name Ufo
extends RigidBody2D

@export var speed: float = 200.0

@export var sprite: Sprite2D 
@export var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D
@export var explosion_resistance: float = 1.0 # 1.0 normal, >1.0 más pesado

# Configuración del centro del área de juego (640x480)
@export var screen_center: Vector2 = Vector2(320.0, 240.0)

func _ready() -> void:
	Eventbus.balloon_exploded.connect(_on_balloon_exploded)
	Eventbus.kill_enemies.connect(queue_free)
	gravity_scale = 0.0
	input_pickable = true
	
	if not input_event.is_connected(_on_input_event):
		input_event.connect(_on_input_event)
		
	if visible_on_screen_notifier_2d and not visible_on_screen_notifier_2d.screen_exited.is_connected(_on_screen_exited):
		visible_on_screen_notifier_2d.screen_exited.connect(_on_screen_exited)

	set_position_and_movement()

func set_position_and_movement() -> void:
	# 1. Spawn original (bordes laterales con Y aleatoria)
	var random_y: float = randf_range(0.0, 480.0)
	var spawn_from_left: bool = randf() > 0.5
	
	if spawn_from_left:
		global_position = Vector2(-20.0, random_y)
	else:
		global_position = Vector2(660.0, random_y)
	
	# 2. Vector dirección hacia el centro
	var direction: Vector2 = global_position.direction_to(screen_center)
	
	# 3. Asignación de velocidad y orientación
	linear_velocity = direction * speed
	sprite.flip_h = direction.x < 0.0

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		die()

func _on_screen_exited() -> void:
	queue_free()

func _on_balloon_exploded(explosion_pos: Vector2, force: float) -> void:
	# Calculamos el vector desde la explosión hacia este objeto
	var direction: Vector2 = explosion_pos.direction_to(global_position)
	
	# Si el objeto está exactamente en el centro, le damos un vector hacia arriba por defecto
	if direction == Vector2.ZERO:
		direction = Vector2.UP
		
	# Distancia opcional para atenuar la fuerza si está muy lejos
	var distance: float = global_position.distance_to(explosion_pos)
	
	blow_up(direction, force, distance)

# Función encargada de aplicar el impulso físico
func blow_up(direction: Vector2, force: float, distance: float) -> void:
	# Puedes calcular una atenuación basada en la distancia si usas un radio
	var final_force: float = (force / explosion_resistance)
	
	# Apagamos temporalmente el modo Freeze si el objeto estaba congelado
	if freeze:
		freeze = false
		
	# Aplicamos el impulso físico directo al centro del cuerpo
	apply_central_impulse(direction * final_force)

func die() -> void:
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	#reproduce sonido
	$Timer.start(5)
	pass
