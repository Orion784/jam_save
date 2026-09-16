extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if %GameTimer != null :
		text = "%.1f" % %GameTimer.time_left 
		#esa cosa rara recorta los decimales del float y hace un parse a string
