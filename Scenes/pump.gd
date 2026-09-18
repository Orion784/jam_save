extends Node2D

class_name Pump

var play : bool = true
var direction : int = 1
var current_failure_zone: int = 0
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.

#mantiene moviendo la aguja del progress bar
func _process(delta: float) -> void:
	if play:
		if $ProgressBar.value == 100 || $ProgressBar.value == 0 :
			direction *= -1
		$ProgressBar.value += 1 * direction

#actualiza la dificultad segun el stage
func refresh(stage) -> void :
	$Failure.value = current_failure_zone

func get_bar_value() -> float :
	return $ProgressBar.value
