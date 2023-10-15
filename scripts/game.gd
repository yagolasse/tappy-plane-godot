extends Node2D
class_name Game

@export var player: Player
@export var blur_rect: BlurRect
@export var get_ready_logo: Sprite2D
@export var game_over_logo: Sprite2D
@export var menu_button: TextureButton
@export var retry_button: TextureButton
@export var include_on_pause: Array[Node2D]

var _paused = false
var _logo_tween: Tween

func _ready() -> void:
	player.game_over.connect(game_over)
	menu_button.pressed.connect(_navigate_to_menu_scene)
	retry_button.pressed.connect(_restart_game)
	_start()


func _navigate_to_menu_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	_pause(false)


func _restart_game() -> void:
	_start()
	get_tree().reload_current_scene()


func _start() -> void:
	_pause(true)
	blur_rect.set_full_screen_blur(false)
	menu_button.visible = false
	retry_button.visible = false
	game_over_logo.modulate.a = 0
	get_ready_logo.modulate.a = 1
	
	blur_rect.reset_full_screen_blur(true)
	_tween_logo_to_alpha(get_ready_logo, 0, func(): _pause(false))


func _pause(should_pause: bool) -> void:
	for item in include_on_pause:
		item.get_tree().paused = should_pause
	
	_paused = should_pause


func _tween_logo_to_alpha(logo: Sprite2D, alpha: float, callback: Callable = Callable()) -> void:
	if _logo_tween:
		_logo_tween.kill()
		
	_logo_tween = get_tree().create_tween().bind_node(self)
	_logo_tween.set_ease(Tween.EASE_OUT).tween_property(logo, "modulate", Color(1, 1, 1, alpha), 1.0)
	
	if callback:
		_logo_tween.tween_callback(callback)


func game_over() -> void:
	_pause(true)
	
	menu_button.visible = true
	retry_button.visible = true
	blur_rect.set_full_screen_blur(true)
	_tween_logo_to_alpha(game_over_logo, 1)
