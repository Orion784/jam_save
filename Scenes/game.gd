extends Node2D

const FIRST_STAGE : int = 1

@export var stages: Stages
@export var enemies: Enemies
@export var balloon: Balloon
@export var pump: Pump
@export var game_timer : Timer
@export var time : float
@export var audio : Audio
var current_stage : int
@export var pump_goal : int = 3
var current_pump : int = 0
var is_low_time : bool = false

func _ready() -> void:
	stages.first_refresh(FIRST_STAGE)
	current_stage = FIRST_STAGE
	audio.start_and_mute_all()
	audio.fade_in_tutorial()
	

func _process(_delta: float) -> void:
	pass

#luego del primer pump si es el primer stage
func start() -> void:
	game_timer.start(time)
	enemies.refresh(current_stage)
	pass

#devuelve todo al principio
func reset() -> void:
	current_stage = FIRST_STAGE
	current_pump = 0
	balloon.reset_balloon()
	stages.refresh(current_stage)
	enemies.refresh(current_stage)
	audio.fade_out_main()
	audio.fade_out_warning()
	audio.fade_in_tutorial()
	$CanvasLayer/PanelContainer.visible = false
	$Pump/ProgressBar/Button.visible = true
	pass # Replace with function body.

#avanza al siguiente stage
func increase_stage(stage : int) -> void :
	current_stage = stage+1
	stages.refresh(current_stage)
	await stages.transicion.on_transition_finished
	balloon.refresh()
	enemies.refresh(current_stage)
	if !is_low_time :
		audio.fade_in_main()
	if current_stage == 5:
		win()
	pass

#comportamiento al bombear
func on_pump() -> void:
	if pump.get_bar_value() > pump.current_failure_zone: #si esta bien 
		print(current_stage)
		print(current_pump)
		if current_stage == FIRST_STAGE && current_pump == 0: #si es la primera de la partida

			start() #comienza el timer
		balloon.balloon_inflate()
		current_pump += 1
		if current_pump == pump_goal: #si reune lo suficiente
			current_pump = 0
			increase_stage(current_stage) #avanza de stage
	else: #sino, explota
		balloon.balloon_pop($coso/Balloon)
		current_pump = 0
		pass # Replace with function body.


func running_out_of_time() -> void:
	audio.fade_out_main()
	audio.fade_out_tutorial()
	audio.fade_in_warning()
	is_low_time = true
	pass # Replace with function body.


func out_of_time() -> void:
	$CanvasLayer/PanelContainer.visible = true
	$Pump/ProgressBar/Button.visible = false
	$TextureRect.start_sun_engulf()
	pass # Replace with function body.

func win() -> void:
	game_timer.stop()
	# esto seria en el panel $GameTimer/Label.visible = false
	pump.visible = false
	var tween := create_tween().set_parallel(true)
	# Calculamos la posición destino restando 700 píxeles en el eje Y
	var target_stage5_pos: Vector2 = $Stages/Stage5/AnimatedSprite2D.position - Vector2(0, 1400)
	var target_coso_pos: Vector2 = $coso.position - Vector2(0, 1400)
	
	# Animamos la propiedad 'position' de ambos nodos durante 3.0 segundos
	tween.tween_property($Stages/Stage5/AnimatedSprite2D, "position", target_stage5_pos, 12.0)
	tween.tween_property($coso, "position", target_coso_pos, 12.0)
