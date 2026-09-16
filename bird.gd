extends Node2D

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

	if global_position.x < 0:
		direction = 1.0
	else:
		direction = -1.0


func _on_body_entered(body: Node) -> void:
	print(id)
	pass # Replace with function body.
