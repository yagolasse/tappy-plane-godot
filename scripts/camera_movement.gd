extends Camera2D
class_name CameraMovement

@export var horizontal_speed: int


func _process(delta: float) -> void:
	position.x += delta * horizontal_speed
