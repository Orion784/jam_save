extends Node2D

@export var enemies : Enemies
@export var spawner_time: float

func set_enemies_timer() -> void :
	enemies.timer.start(spawner_time)

func spawn_enemies() -> void:
	var meteor_instance = enemies.meteor.instantiate()
	add_child(meteor_instance)
