extends CanvasLayer
class_name MainMenu

@export var play_button: TextureButton

func _ready() -> void:
	play_button.pressed.connect(_navigate_to_game_scene)


func _navigate_to_game_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
