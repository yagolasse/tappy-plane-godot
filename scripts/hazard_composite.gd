extends Node2D
class_name HazardComposite

signal point_scored

@export var max_y_offset: float
@export var max_hazard_offset: Vector2
@export var point_area: Area2D
@export var top_hazard: StaticBody2D
@export var bottom_hazard: StaticBody2D
@export var visibility_notifier: VisibleOnScreenNotifier2D

var hazards_layer: HazardsLayer

var _random: RandomNumberGenerator

var _initial_y_position: float
var _intial_top_hazard_position: Vector2
var _intial_bottom_hazard_position: Vector2


func _ready() -> void:
	_random = RandomNumberGenerator.new()
	
	_initial_y_position = position.y
	_intial_top_hazard_position = top_hazard.position
	_intial_bottom_hazard_position = bottom_hazard.position
	
	_prepare()
	
	point_area.body_exited.connect(_on_point_area_body_exited)
	visibility_notifier.screen_exited.connect(_on_visibility_notifier_screen_exited)


func _prepare() -> void:
	var y_offset = _random.randf_range(-max_y_offset, max_y_offset)
	var top_hazard_y_offset = _random.randf_range(-max_hazard_offset.y, max_hazard_offset.y)
	var top_hazard_x_offset = _random.randf_range(-max_hazard_offset.x, max_hazard_offset.x)
	var bottom_hazard_y_offset = _random.randf_range(-max_hazard_offset.y, max_hazard_offset.y)
	var bottom_hazard_x_offset = _random.randf_range(-max_hazard_offset.x, max_hazard_offset.x)
	
	position.y = _initial_y_position + y_offset
	top_hazard.position = _intial_top_hazard_position - Vector2(top_hazard_x_offset, top_hazard_y_offset) / 2
	bottom_hazard.position = _intial_bottom_hazard_position - Vector2(bottom_hazard_x_offset, bottom_hazard_y_offset) / 2
	# TODO: random decorative spikes


func _on_point_area_body_exited(body: Node2D) -> void:
	if body is Player:
		point_scored.emit()


func _on_visibility_notifier_screen_exited() -> void:
	_prepare()
	
	position.x = hazards_layer.furtherest_x_position + hazards_layer.hazard_distance
	hazards_layer.furtherest_x_position = position.x
