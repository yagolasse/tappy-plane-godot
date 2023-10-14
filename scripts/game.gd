extends Node2D
class_name Game

@export var player: Player
@export var blur_rect: BlurRect
@export var include_on_pause: Array[Node2D]

var _paused = false

func _ready() -> void:
	player.game_over.connect(game_over)


func _process(_delta: float) -> void:
	if _paused and Input.is_action_just_pressed("ui_end"):
		_pause(false)
		blur_rect.set_full_screen_blur(0, false)
		get_tree().reload_current_scene()


func _pause(should_pause: bool) -> void:
	for item in include_on_pause:
		item.get_tree().paused = should_pause
	
	_paused = should_pause


func game_over() -> void:
	_pause(true)
	
	blur_rect.set_full_screen_blur(3, true)
