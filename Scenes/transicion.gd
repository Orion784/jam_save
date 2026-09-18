extends ColorRect

signal on_transition_finished
@onready var animation_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		animation_player.play("fade_black_to_normal")
		$"../../GameTimer".paused = false
	elif anim_name == "fade_black_to_normal":
		visible = false
	pass # Replace with function body.

func transition() -> void:
	visible = true
	animation_player.play("fade_to_black")
	$"../../GameTimer".paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
