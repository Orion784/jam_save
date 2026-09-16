extends Node2D



func _ready() -> void:
	pass

func set_stage(stage) -> void :
	#aqui deberia fundir a negro
	turn_off()
	match stage :
		#1: $Stage1.visible = true
		2: set_cat()
		3: set_birds()
		#4: $Stage4.visible = true
		#5: $Stage5.visible = true

func turn_off() -> void :
	$Cat.process_mode = PROCESS_MODE_DISABLED
	$birds.process_mode = Node.PROCESS_MODE_DISABLED

func set_cat() ->void:
	$Cat.process_mode = PROCESS_MODE_INHERIT
	$Cat.reset()
func set_birds() ->void:
	$birds.process_mode = PROCESS_MODE_INHERIT
	$birds/Bird.reset()
	$birds/Bird2.reset()
	$birds/Bird3.reset()
	$birds/Bird4.reset()
