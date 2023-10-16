extends Resource
class_name PlayerSpriteSkin

enum SkinColor { 
	RED,
	BLUE,
	GREEN,
	YELLOW,
}

@export var player_skin_red: SpriteFrames
@export var player_skin_blue: SpriteFrames
@export var player_skin_green: SpriteFrames
@export var player_skin_yellow: SpriteFrames

@export var player_texture_red: Texture2D
@export var player_texture_blue: Texture2D
@export var player_texture_green: Texture2D
@export var player_texture_yellow: Texture2D

var player_skin: Dictionary = {
	SkinColor.RED: player_skin_red,
	SkinColor.BLUE: player_skin_blue,
	SkinColor.GREEN: player_skin_green,
	SkinColor.YELLOW: player_skin_yellow,
}

var player_texture: Dictionary = {
	SkinColor.RED: player_texture_red,
	SkinColor.BLUE: player_texture_blue,
	SkinColor.GREEN: player_texture_green,
	SkinColor.YELLOW: player_texture_yellow,
}

var current_player_skin: int = SkinColor.RED : set = _set_current_player_skin


func _set_current_player_skin(value: SkinColor) -> void:
	current_player_skin = value if value < 4 else 0
