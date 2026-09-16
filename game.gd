extends Node2D

class_name GameManager

var current_stage = 1
var succesfull_pump = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_dificult()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func on_player_pump() -> void:
	if $PumpManager.get_progress_bar_value() >= succesfull_pump * current_stage :
		$BaloonManager.inflate()
	pass # Replace with function body.

func on_reset_button() -> void:
	$BaloonManager.reset_ballon()

func set_dificult() -> void:
	$PumpManager/Failure.value = succesfull_pump * current_stage
	pass
