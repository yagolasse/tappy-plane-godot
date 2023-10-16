extends CharacterBody2D
class_name Player

signal game_over

@export var flap_speed: int 
@export var player_skin_red: SpriteFrames
@export var player_skin_blue: SpriteFrames
@export var player_skin_green: SpriteFrames
@export var player_skin_yellow: SpriteFrames
@export var visibility_notifier: VisibleOnScreenNotifier2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var gravity_magnitude: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	visibility_notifier.screen_exited.connect(_on_visibility_notifier_screen_exited)
	sprite.sprite_frames = player_skin_blue
	sprite.play("engine_on")


func _physics_process(delta: float) -> void:
	velocity.y += gravity_magnitude * delta
	
	var collision = move_and_collide(velocity * delta)
	
	if Input.is_key_pressed(KEY_1):
		sprite.sprite_frames = player_skin_red
		sprite.play("engine_on")
	if Input.is_key_pressed(KEY_2):
		sprite.sprite_frames = player_skin_blue
		sprite.play("engine_on")
	if Input.is_key_pressed(KEY_3):
		sprite.sprite_frames = player_skin_green
		sprite.play("engine_on")
	if Input.is_key_pressed(KEY_4):
		sprite.sprite_frames = player_skin_yellow
		sprite.play("engine_on")
	
	if collision and collision.get_collider().is_in_group(Groups.HAZARDS):
		game_over.emit()


func _input(event: InputEvent) -> void:
	var is_tapping = event is InputEventScreenTouch and event.is_pressed()
	
	if event.is_action_pressed("flap") or is_tapping:
		velocity.y = -flap_speed


func _on_visibility_notifier_screen_exited() -> void:
	game_over.emit()
