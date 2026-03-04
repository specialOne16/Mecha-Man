extends Label
class_name PlayerDebug

@export var player: Player

func _process(_delta: float) -> void:
	text = """
		Player velocity: %.2f, %.2f
	""" % [player.linear_velocity.x, player.linear_velocity.y]
