extends RigidBody2D

class_name Meteor
@export var speed: float = 200.0
@export var explosion_resistance: float = 1.0 # 1.0 normal, >1.0 más pesado

@export var sprite: Sprite2D
@export var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D

# Dimensiones de pantalla/área de juego
@export var screen_width: float = 640.0
@export var spawn_y: float = -20.0

func _ready() -> void:
	Eventbus.kill_enemies.connect(queue_free)
	Eventbus.balloon_exploded.connect(_on_balloon_exploded)
	$sprite2.visible = false
	var eleccion = randf_range(0.0, 1.0)
	if eleccion >= 0.5 :
		sprite.texture = $sprite2.texture
	set_position_and_movement()
func set_position_and_movement() -> void:
	# 1. Posición aleatoria en el borde superior
	var random_x: float = randf_range(0.0, screen_width)
	global_position = Vector2(random_x, spawn_y)
	
	# 2. Dirección hacia el centro de la pantalla
	var screen_center: Vector2 = Vector2(screen_width / 2.0, 480.0 / 2.0)
	var direction: Vector2 = global_position.direction_to(screen_center)
	
	# 3. Asignación de velocidad física
	linear_velocity = direction * speed
	
	# 4. Orientación del Sprite según la trayectoria horizontal
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
	sprite.visible = false
	$CollisionShape2D.disabled = true
	#reproduce sonido
	$Timer.start(5)
	pass
