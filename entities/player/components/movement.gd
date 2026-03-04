extends Node
class_name PlayerMovement

@onready var node_2d: Node2D = $"../../Node2D"
@onready var player: Player = $"../.."

@export var movement_aim: GUIDEAction
@export var movement_thrust: GUIDEAction

var _direction: Vector2 = Vector2.RIGHT

func _physics_process(_delta: float) -> void:
	if movement_aim.value_axis_2d != Vector2.ZERO:
		_direction = -movement_aim.value_axis_2d.normalized()
	
	node_2d.rotation = (-_direction).angle()
	if movement_thrust.value_axis_1d > 0:
		player.apply_central_force(_direction * lerp(player.min_jet_force, player.max_jet_force, movement_thrust.value_axis_1d))
	else:
		var stopping_direction = -player.linear_velocity
		if stopping_direction.y < 0: stopping_direction.y = 0
		player.apply_central_force(stopping_direction * player.stopping_force)
