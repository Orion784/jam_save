extends Timer

signal low_time
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = str(int(time_left))
	if int($Label.text) == 10 : 
		low_time.emit()
	
