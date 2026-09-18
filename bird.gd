class_name Bird
extends RigidBody2D

@export var speed: float = 200.0
@export var explosion_resistance: float = 1.0 # 1.0 normal, >1.0 más pesado

@export var animated_sprite_2d: AnimatedSprite2D 
@export var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D

func _ready() -> void:
	set_position_and_movement()
	Eventbus.balloon_exploded.connect(_on_balloon_exploded)
	Eventbus.kill_enemies.connect(queue_free)

func set_position_and_movement() -> void:
	var random_y: float = randf_range(0.0, 480.0)
	var spawn_from_left: bool = randf() > 0.5
	
	if spawn_from_left:
		global_position = Vector2(-20.0, random_y)
		linear_velocity = Vector2(speed, 0.0)
		animated_sprite_2d.flip_h = false
	else:
		global_position = Vector2(660.0, random_y)
		linear_velocity = Vector2(-speed, 0.0)
		animated_sprite_2d.flip_h = true

#al hacer click, muere. en realidad deberia hacer una animacion, reproducir un sonido y luego queue_free
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# Detección del clic izquierdo sobre la colisión del objeto
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
	$AnimatedSprite2D.visible = false
	$CollisionShape2D.disabled = true
	#reproduce sonido
	$Timer.start(5)
	pass
