extends ParallaxLayer
class_name HazardsLayer

const HazardComposite: Resource = preload("res://packed_scene/hazard_composite.tscn")

@export var hazard_distance: int
@export var initial_hazard_count: int
@export var first_spawn_position: Node2D 

var furtherest_x_position: float


func _ready() -> void:
	for i in range(initial_hazard_count):
		var hazard_composite: HazardComposite = HazardComposite.instantiate()
		var x_position = first_spawn_position.position.x + i * hazard_distance
		
		hazard_composite.position = Vector2.RIGHT * x_position
		hazard_composite.hazards_layer = self

		if i == initial_hazard_count - 1:
			furtherest_x_position = x_position
			
		add_child(hazard_composite)
