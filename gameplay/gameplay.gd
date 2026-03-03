extends Node2D

@export var in_game_mode: GUIDEMappingContext

func _ready() -> void:
	GUIDE.enable_mapping_context(in_game_mode)
