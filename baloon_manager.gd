extends Node2D

class_name BallonManager

#TODO: ANIMAR USANDO TWEENS

@export var balloon : RigidBody2D
@export var balloon_sprite : Sprite2D
@export var balloon_hitbox : CollisionShape2D
@export var is_tutorial : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	balloon.mass = 0.4
	pass # Replace with function body.

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
		$Balloon.mass = 0.04
		if  balloon.gravity_scale >= 0 :
			balloon.gravity_scale = 0
		balloon.gravity_scale -= 0.3
		if balloon.gravity_scale >= -1:
			balloon.gravity_scale = -1
	balloon_sprite.scale += Vector2(3,3)
	balloon_hitbox.scale += Vector2(3,3)

func _process(delta: float) -> void:
	pass
