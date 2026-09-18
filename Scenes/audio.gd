extends Node2D

class_name Audio

@export var main: AudioStreamPlayer2D
@export var tutorial: AudioStreamPlayer2D
@export var warning: AudioStreamPlayer2D

const TRANSITION_TIME: float = 1
const MUTE_DB: float = -80.0
const NORMAL_DB: float = 0.0

# Inicia la reproducción de todos los nodos en silencio absoluto
func start_and_mute_all() -> void:
	main.volume_db = MUTE_DB
	tutorial.volume_db = MUTE_DB
	warning.volume_db = MUTE_DB
	
	main.play()
	tutorial.play()
	warning.play()

# --- MAIN THEME ---
func fade_in_main() -> void:
	_fade_volume(main, NORMAL_DB)

func fade_out_main() -> void:
	_fade_volume(main, MUTE_DB)

# --- TUTORIAL ---
func fade_in_tutorial() -> void:
	_fade_volume(tutorial, NORMAL_DB)

func fade_out_tutorial() -> void:
	_fade_volume(tutorial, MUTE_DB)

# --- WARNING ---
func fade_in_warning() -> void:
	_fade_volume(warning, NORMAL_DB)

func fade_out_warning() -> void:
	_fade_volume(warning, MUTE_DB)

# Función interna desacoplada para animar el volumen de cualquier reproductor de forma independiente
func _fade_volume(player: AudioStreamPlayer2D, target_db: float) -> void:
	var tween := create_tween()
	tween.tween_property(player, "volume_db", target_db, TRANSITION_TIME)
