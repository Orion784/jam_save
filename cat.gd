extends RigidBody2D

var jump_check : float 
var on_air: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Attack.start(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !on_air:
		global_position.x += delta * 100 #direccion del globo menos el centro

func _on_attack_timeout() -> void:
	if !on_air :
		jump_check = randf_range(0.0,1.0)
		if jump_check >= 0.5:
			apply_central_impulse(Vector2(500,-500)) #direccion del globo
			on_air = true


func _on_body_entered(body: Node) -> void:
	if body == $"../../BaloonManager/ground" :
		on_air = false

func reset() -> void:
	global_position = [Vector2(-60,432),Vector2(684,-427)].pick_random()
