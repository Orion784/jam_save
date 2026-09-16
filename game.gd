extends Node2D

class_name GameManager

@export var current_stage : int = 1
var pump_failure : int = 20
var current_pump : int = 0
var pump_goal : int = 3
signal Goal_meet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set_dificult()
	pass # Replace with function body.

func _process(_delta: float) -> void:
	pass



func on_balloon_hit(body : Node2D) -> void:
	if body == %Balloon :
		%Balloon.queue_free() #deberia explotar y mandar todo a la xuxa
		#luego esperar un poco y llamar a resetear todo
		#current_stage = 1
		#set_level(current_stage)
func on_player_pump() -> void:
	if $PumpManager.get_progress_bar_value() >= pump_failure * current_stage :
		$BaloonManager.inflate()
		current_pump += 1
		if current_pump == pump_goal:
			Goal_meet.emit()
	else :
		#explotar y mandar todo a la mrda
		pass
func on_reset_button() -> void: 
	current_stage = 1 
	$BaloonManager.is_tutorial = true
	set_stage(current_stage)
	$BaloonManager.empty_ballon()
func set_stage(stage) ->void:
	$TransitionManager.set_stage(stage)
	$EnemyManager.set_stage(current_stage)
	$PumpManager/Failure.value = pump_failure * current_stage
	pass
func _on_goal_meet() -> void:
	current_pump = 0
	current_stage +=1
	$BaloonManager.is_tutorial = false
	set_stage(current_stage)
	$BaloonManager.reset_balloon()
	pass # Replace with function body.
