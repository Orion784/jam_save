extends Node2D

func _ready() -> void:
	pass

func set_stage(stage) -> void :
	turn_off()
	match stage :
		2: set_cat()
		3: set_birds()

func turn_off() -> void :
	# Para el Gato (RigidBody2D): Usamos freeze en lugar de process_mode
	$Cat.freeze = true
	$Cat.visible = false
	$Cat.reset()
	
	# Para los Pájaros (Area2D): process_mode funciona correctamente
	$birds.process_mode = Node.PROCESS_MODE_DISABLED
	$birds.visible = false
	$birds/Bird.reset()
	$birds/Bird2.reset()
	$birds/Bird3.reset()
	$birds/Bird4.reset()

func set_cat() -> void:
	# 1. Despertar lógico (Por si se desactivó desde el panel Inspector)
	$Cat.process_mode = Node.PROCESS_MODE_INHERIT
	
	# 2. Despertar físico
	$Cat.freeze = false
	$Cat.sleeping = false
	
	# 3. Despertar visual y de estado
	$Cat.visible = true
	$Cat.on_air = false
	
	# 4. Teleportar
	$Cat.reset()
	
	# 5. ¡Crucial! Reiniciar el reloj de salto
	$Cat.get_node("Attack").start(2)

func set_birds() -> void:
	$birds.process_mode = Node.PROCESS_MODE_INHERIT
	$birds.visible = true
	$birds/Bird.reset()
	$birds/Bird2.reset()
	$birds/Bird3.reset()
	$birds/Bird4.reset()
