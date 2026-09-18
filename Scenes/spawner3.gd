extends Node2D

@export var enemies : Enemies
@export var spawner_time: float

func set_enemies_timer() -> void :
	enemies.timer.start(spawner_time)

func spawn_enemies() -> void:
	var ufo_instance = enemies.ufo.instantiate()
	add_child(ufo_instance)
