extends Node2D

@export var stage_sprites : Array[Texture2D]
@export var current_sprite : Sprite2D

func _ready() -> void :
	current_sprite.texture = stage_sprites[0]
