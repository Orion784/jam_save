extends Node2D

var goal : int = 1

func get_progress_bar_value() -> float :
	return $ProgressBar.value
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $ProgressBar.value == 100 || $ProgressBar.value == 0 :
		goal *= -1
	$ProgressBar.value += 1 * goal
