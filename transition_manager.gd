extends Node2D

@export var stage_sprites : Array[Texture2D]
@export var current_sprite : Sprite2D
var rng  : float

func _ready() -> void:
	turn_off()
	set_stage(1)

func set_stage(stage) -> void :
	#aqui deberia fundir a negro
	turn_off()
	match stage :
		1: $Stage1.visible = true
		2: $Stage2.visible = true
		3: $Stage3.visible = true
		4: $Stage4.visible = true
		5: $Stage5.visible = true

func turn_off() -> void :
	$Stage1.visible = false
	$Stage2.visible = false
	$Stage3.visible = false
	$Stage4.visible = false
	$Stage5.visible = false
