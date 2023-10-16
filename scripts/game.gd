extends Node2D
class_name Game

const SCORE_TEXT := "SCORE: %d"
const TOP_SCORE_TEXT := "HIGHSCORE: %d"

@export var player: Player
@export var blur_rect: BlurRect
@export var hazards_layer: HazardsLayer
@export var score_repository: ScoreRepository
@export var include_on_pause: Array[Node2D]

@export_category("UI")
@export var get_ready_logo: TextureRect
@export var game_over_logo: TextureRect
@export var score_label: Label
@export var top_score_label: Label
@export var menu_button: TextureButton
@export var retry_button: TextureButton

var _paused = false
var _top_score: int
var _logo_tween: Tween
var _current_score: int: set = _set_current_score

func _ready() -> void:
	score_repository.load_current_high_score()
	top_score_label.text = TOP_SCORE_TEXT % score_repository.top_score
	
	player.game_over.connect(game_over)
	menu_button.pressed.connect(_navigate_to_menu_scene)
	retry_button.pressed.connect(_restart_game)
	
	for child in hazards_layer.get_children():
		if child is HazardComposite:
			(child as HazardComposite).point_scored.connect(_point_scored)
	
	_start()


func _point_scored() -> void:
	_current_score += 1


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
	
	_current_score = 0
	
	blur_rect.reset_full_screen_blur(true)
	_tween_logo_to_alpha(get_ready_logo, 0, func(): _pause(false))


func _pause(should_pause: bool) -> void:
	for item in include_on_pause:
		item.get_tree().paused = should_pause
	
	_paused = should_pause


func _tween_logo_to_alpha(logo: TextureRect, alpha: float, callback: Callable = Callable()) -> void:
	if _logo_tween:
		_logo_tween.kill()
		
	_logo_tween = get_tree().create_tween().bind_node(self)
	_logo_tween.set_ease(Tween.EASE_OUT).tween_property(logo, "modulate", Color(1, 1, 1, alpha), 1.0)
	
	if callback:
		_logo_tween.tween_callback(callback)


func _set_current_score(value: int) -> void:
	_current_score = value
	score_label.text = SCORE_TEXT % value


func game_over() -> void:
	_pause(true)
	
	score_repository.save_score_if_higher(_current_score)
	top_score_label.text = TOP_SCORE_TEXT % score_repository.top_score
	
	menu_button.visible = true
	retry_button.visible = true
	blur_rect.set_full_screen_blur(true)
	_tween_logo_to_alpha(game_over_logo, 1)
