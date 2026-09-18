extends Node2D

class_name Stages
@export var transicion : ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func refresh(stage : int) ->void :
	transicion.transition()
	Eventbus.kill_enemies.emit()
	await transicion.on_transition_finished
	$"../TextureRect".reset_effect()
	turn_off()
	match stage:
		1:$Stage1.visible = true
		2:$Stage2.visible = true
		3:$Stage3.visible = true
		4:$Stage4.visible = true
		5:$Stage5.visible = true
	pass

func first_refresh(stage : int) ->void :
	turn_off()
	match stage:
		1:$Stage1.visible = true
		2:$Stage2.visible = true
		3:$Stage3.visible = true
		4:$Stage4.visible = true
		5:$Stage5.visible = true
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func turn_off() -> void:
	$Stage1.visible = false
	$Stage2.visible = false
	$Stage3.visible = false
	$Stage4.visible = false
	$Stage5.visible = false
