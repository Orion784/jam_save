extends Node2D

class_name Enemies

@onready var bird : PackedScene = load("res://Scenes/birds/bird.tscn")
@onready var ufo : PackedScene = load("res://Scenes/ufo/ufo.tscn")
@onready var meteor : PackedScene = load("res://Scenes/meteor/meteor.tscn")
@export var timer : Timer

@onready var current_node: Node2D = $Spawner1 #apunta a el nodo donde va a usar su funcion

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

#apunta al spawner correspondiente
func refresh(stage : int) -> void :
	match stage:
		1 : current_node = $Spawner1
		2 : current_node = $Spawner2
		3 : current_node = $Spawner3
		4 : current_node = $Spawner4
		_: current_node = $Spawner1
		#5 : current_node = $Spawner1
		#5 : current_node = $Spawner1
	timer.start(current_node.spawner_time) # y le da inicio a su timer
#spawnea enemigos y vuelve a largar el timer
func _on_timer_timeout() -> void:
	current_node.spawn_enemies()
	timer.start(current_node.spawner_time)
