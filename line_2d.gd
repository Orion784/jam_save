extends Line2D

@export var anclaje_piso: Node2D      # Arrastra el StaticBody2D
@export var globo: RigidBody2D        # Arrastra el RigidBody2D del globo
@export var cantidad_puntos: int = 6  # Subir para más flexibilidad
@export var longitud_segmento: float = 12.0 # Distancia fija e indestructible entre puntos
@export var iteraciones_rigidez: int = 5 # Más iteraciones = más rígida la cuerda

var posiciones: Array[Vector2] = []
var posiciones_previas: Array[Vector2] = []

func _ready() -> void:
	clear_points()
	var pos_inicial = anclaje_piso.global_position
	for i in range(cantidad_puntos):
		var p = pos_inicial + Vector2(0, -i * longitud_segmento)
		posiciones.append(p)
		posiciones_previas.append(p)
		add_point(p)

func _physics_process(delta: float) -> void:
	# 1. Simular movimiento de los puntos intermedios (Verlet)
	for i in range(1, cantidad_puntos - 1):
		var velocidad = posiciones[i] - posiciones_previas[i]
		posiciones_previas[i] = posiciones[i]
		# Gravedad leve para la cuerda
		posiciones[i] += velocidad + Vector2(0, 98.0) * delta * delta

	# 2. Fijar los extremos
	posiciones[0] = anclaje_piso.global_position
	# El nudo inferior del globo es el último punto
	posiciones[cantidad_puntos - 1] = globo.global_position 

	# 3. Aplicar restricciones de distancia indeformable (Garantiza que NO se separen)
	for _it in range(iteraciones_rigidez):
		_resolver_restricciones()

	# 4. Transmitir la tensión final al Globo
	var vector_tirón = posiciones[cantidad_puntos - 1] - globo.global_position
	globo.global_position += vector_tirón # Mantiene al globo atado sin estirar

	# 5. Renderizar los puntos en el Line2D
	for i in range(cantidad_puntos):
		set_point_position(i, posiciones[i])

func _resolver_restricciones() -> void:
	for i in range(cantidad_puntos - 1):
		var p1 = posiciones[i]
		var p2 = posiciones[i + 1]
		var dir = p2 - p1
		var dist_actual = dir.length()
		var error = dist_actual - longitud_segmento
		
		if dist_actual > 0.0001:
			var correccion = dir.normalized() * error
			if i == 0:
				# El piso es fijo, todo se corrige en p2
				posiciones[i + 1] -= correccion
			elif i + 1 == cantidad_puntos - 1:
				# El punto del globo se corrige en p1
				posiciones[i] += correccion
			else:
				# Puntos intermedios se ajustan por igual
				posiciones[i] += correccion * 0.5
				posiciones[i + 1] -= correccion * 0.5
