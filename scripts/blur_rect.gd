extends ColorRect
class_name BlurRect

const BLUR_STRENGHT_PARAMETER := "shader_parameter/blur_strenght" 

@export var node_to_bind: Node
@export var max_blur_strenght: float
@export var blur_animation_duration: float

var _blur_tween: Tween


func set_full_screen_blur(value: float, animate: bool) -> void:
	if _blur_tween:
		_blur_tween.kill()
	
	if animate: 
		_blur_tween = get_tree().create_tween().bind_node(node_to_bind)
		_blur_tween.set_ease(Tween.EASE_OUT).tween_method(_set_blur_strenght, 0.0, max_blur_strenght, blur_animation_duration)
	else:
		_set_blur_strenght(value)


func _set_blur_strenght(value: float) -> void:
	material.set(BLUR_STRENGHT_PARAMETER, value)
