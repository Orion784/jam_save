extends RigidBody2D # Debe ser Area2D para detectar clics en este contexto

class_name Bird

@export var id: int
@export var speed: float = 100.0

var height: float = 480.0
var width: float = 640.0
var direction: float = -1.0
var margin_extra: float = 100.0 # Píxeles fuera de pantalla antes de resetear

func _ready() -> void:
	reset()

func _process(delta: float) -> void:
	if %Balloon != null:
		global_position.x += speed * delta * direction
		if global_position.x < -margin_extra or global_position.x > (width + margin_extra):
			reset()

func reset() -> void:
	var spawn_x: float = [-margin_extra, width + margin_extra].pick_random()
	var spawn_y: float = randf_range(50.0, height - 50.0)
	
	global_position = Vector2(spawn_x, spawn_y)

	# Dirección de vuelo
	if global_position.x < 0:
		direction = 1.0
		$AnimatedSprite2D.flip_h = false # Mira hacia la derecha
	else:
		direction = -1.0
		$AnimatedSprite2D.flip_h = true  # Invierte la imagen para mirar a la izquierda
	
	global_position = Vector2(spawn_x, spawn_y)

	if global_position.x < 0:
		direction = 1.0
	else:
		direction = -1.0

func _on_body_entered(body: Node) -> void:
	print(id)
	pass # Aca reventará el globo

# --- NUEVO CÓDIGO ---
func _input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# Verificamos el evento
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		reset() # Un solo clic reinicia la posición del pájaro, alejándolo del globo
