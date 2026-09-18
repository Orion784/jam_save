extends TextureRect

@export var duration: float = 2.0

func _ready() -> void:
	# Aseguramos que ocupe la pantalla y el pivote esté en el borde izquierdo (0, 0)
	pivot_offset = Vector2.ZERO
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	
	# Estado inicial: oculto y comprimido horizontalmente
	visible = false
	scale.x = 0.0

# Dispara la ola del sol
func start_sun_engulf() -> void:
	var screen_size: Vector2 = get_viewport_rect().size
	
	# Forzamos a que el nodo llene el Viewport completo
	size = screen_size
	scale = Vector2(0.0, 1.0)
	visible = true
	
	var tween := create_tween().set_parallel(true)
	
	# 1. Expandimos la escala X de 0 a 1 (efecto barrido de izquierda a derecha)
	tween.tween_property(self, "scale:x", 1.0, duration)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_IN)
		
	# 2. Aumentamos el brillo para el efecto incandescente (Glow)
	modulate = Color.WHITE
	tween.tween_property(self, "modulate:v", 2.5, duration)

# Resetea el efecto inmediatamente sin animación
func reset_effect() -> void:
	visible = false
	scale = Vector2(0.0, 1.0)
