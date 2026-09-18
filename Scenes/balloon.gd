extends RigidBody2D

class_name Balloon
@export var explosion_area: Area2D
@export var explosion_force: float = 800.0 # Fuerza del empuje
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#lleva el globo a un estado normal para comenzar los stages
func refresh() -> void:
	$Sprite2D.scale = Vector2(5,5)
	$CollisionShape2D.scale = Vector2(5,5)

#infla el globo
func balloon_inflate() -> void:
	$Sprite2D.scale += Vector2(5,5)
	%CollisionShape2D.scale += Vector2(5,5)
	
#para volver a empezar la partida (esto deberia mostrar otra vez un globo normal)
func reset_balloon() -> void:
	$Sprite2D.visible = true
	self.gravity_scale = -1
	self.mass = 0.2
	refresh()

#si el globo revienta, explota (se desactiva por ahora)
func balloon_pop(body: Node) -> void:
	$Sprite2D.visible = false
	$Sprite2D.scale = Vector2(1,1)
	$CollisionShape2D.scale = Vector2(1,1)
	self.mass = 1
	self.gravity_scale = 1
	Eventbus.balloon_exploded.emit(global_position, explosion_force)
	$"../../GameTimer".start(0.1)
