extends CharacterBody2D
class_name Player

@export var flap_speed: int 
@export var player_skin_blue: SpriteFrames
@export var visibility_notifier: VisibleOnScreenNotifier2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	visibility_notifier.screen_exited.connect(_on_visibility_notifier_screen_exited)
	sprite.sprite_frames = player_skin_blue
	sprite.play("flap")


func _physics_process(delta: float) -> void:
	velocity.y += gravity_magnitude * delta
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = -flap_speed
	
	var _collision = move_and_collide(velocity * delta)


func _on_visibility_notifier_screen_exited() -> void:
	print("Exited screen")
