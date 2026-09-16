extends Node2D

class_name BallonManager

#TODO: ANIMAR USANDO TWEENS

# Reemplazamos @export por @onready para asegurar el enlace automático
@onready var balloon : RigidBody2D = %Balloon
@onready var balloon_sprite : Sprite2D = %Balloon/Sprite2D
@onready var balloon_hitbox : CollisionShape2D = %Balloon/CollisionShape2D

@export var is_tutorial : bool = true

func _ready() -> void:
	balloon.mass = 0.4

func empty_ballon() -> void :
	balloon_sprite.scale = Vector2(10,10)
	balloon_hitbox.scale = Vector2(10,10)
	balloon.gravity_scale = 1
	is_tutorial = true

func reset_balloon() -> void :
	balloon_sprite.scale = Vector2(10,10)
	balloon_hitbox.scale = Vector2(10,10)

func inflate() -> void :
	if is_tutorial :
		balloon.mass = 0.04 # Usamos la variable en lugar de $Balloon
		if balloon.gravity_scale >= 0 :
			balloon.gravity_scale = 0
		balloon.gravity_scale -= 0.3
		if balloon.gravity_scale >= -1:
			balloon.gravity_scale = -1
	balloon_sprite.scale += Vector2(3,3)
	balloon_hitbox.scale += Vector2(3,3)

func _process(delta: float) -> void:
	pass
