class_name VerletRope2D
extends Node2D

@export_group("Referencias")
@export var anchor_static_body: StaticBody2D
@export var balloon_body: RigidBody2D

@export_group("Configuración de Soga")
@export var point_count: int = 15
@export var segment_length: float = 10.0
@export var constraint_iterations: int = 15
@export var gravity: Vector2 = Vector2(0, 300) # Peso de la cuerda (curvatura)
@export var line_width: float = 3.0
@export var line_color: Color = Color.WHITE

@export_group("Tensión y Resistencia")
@export var rope_stiffness: float = 0.8 # Resistencia de estiramiento (0.1 a 1.0)
@export var damping: float = 0.95 # Freno de oscilación

var points: Array[Vector2] = []
var old_points: Array[Vector2] = []
var max_rope_length: float = 0.0

func _ready() -> void:
	max_rope_length = (point_count - 1) * segment_length
	_initialize_rope()

func _initialize_rope() -> void:
	points.clear()
	old_points.clear()
	
	var start_pos: Vector2 = anchor_static_body.global_position if anchor_static_body else global_position
	
	for i in range(point_count):
		var p: Vector2 = start_pos + Vector2(0, i * segment_length)
		points.append(p)
		old_points.append(p)

func _physics_process(delta: float) -> void:
	_update_points(delta)
	_apply_constraints()
	_apply_tension_to_balloon(delta)
	queue_redraw()

func _update_points(delta: float) -> void:
	for i in range(point_count):
		var velocity: Vector2 = (points[i] - old_points[i]) * damping
		old_points[i] = points[i]
		points[i] += velocity + gravity * delta * delta

func _apply_constraints() -> void:
	# 1. Anclaje al StaticBody
	if anchor_static_body:
		points[0] = anchor_static_body.global_position

	# 2. Resolución de segmentos de Verlet
	for _iter in range(constraint_iterations):
		for i in range(point_count - 1):
			var p1: Vector2 = points[i]
			var p2: Vector2 = points[i + 1]
			
			var dist: float = p1.distance_to(p2)
			var error: float = dist - segment_length
			var change: Vector2 = p1.direction_to(p2) * error * rope_stiffness
			
			if i == 0:
				points[i + 1] -= change
			else:
				points[i] += change * 0.5
				points[i + 1] -= change * 0.5

# 3. Aplicar Tensión Física al RigidBody2D (Límite Finito de la Soga)
func _apply_tension_to_balloon(_delta: float) -> void:
	if not balloon_body or not anchor_static_body:
		return

	# Fijar el último punto a la posición real del globo
	points[point_count - 1] = balloon_body.global_position

	var anchor_pos: Vector2 = anchor_static_body.global_position
	var balloon_pos: Vector2 = balloon_body.global_position
	var current_distance: float = anchor_pos.distance_to(balloon_pos)

	# Si el globo supera la longitud total permitida de la soga:
	if current_distance > max_rope_length:
		# Dirección desde el globo hacia el ancla (fuerza de retención)
		var pull_direction: Vector2 = balloon_pos.direction_to(anchor_pos)
		var excess_distance: float = current_distance - max_rope_length
		
		# Proyectar el globo al límite de la soga
		balloon_body.global_position = anchor_pos + (balloon_pos.direction_to(anchor_pos) * -max_rope_length)
		
		# Anular la velocidad física que vaya en dirección opuesta al ancla
		var vel_dot: float = balloon_body.linear_velocity.dot(-pull_direction)
		if vel_dot > 0:
			balloon_body.linear_velocity -= -pull_direction * vel_dot

func _draw() -> void:
	if points.size() < 2:
		return
		
	for i in range(points.size() - 1):
		draw_line(to_local(points[i]), to_local(points[i + 1]), line_color, line_width)
