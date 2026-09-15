extends Node2D

class_name GameManager

var current_stage = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func player_pump() -> void:
	#if $PumpManager.current_value >= desired_value:
	#	$BaloonManager.inflate()
	$BaloonManager.inflate()
	pass # Replace with function body.
