extends Node
class_name PlayerMovement

@onready var node_2d: Node2D = $"../../Node2D"

@export var body: RigidBody2D
@export var parameters: PlayerParameters

@export var movement_aim: GUIDEAction
@export var movement_thrust: GUIDEAction

var _direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if movement_aim.value_axis_2d != Vector2.ZERO:
		_direction = -movement_aim.value_axis_2d
	
	node_2d.rotation = (-_direction).angle()
	if movement_thrust.value_axis_1d > 0:
		body.apply_central_force(_direction * lerp(parameters.min_rocket_force, parameters.max_rocket_force, movement_thrust.value_axis_1d))
	body.apply_central_force(-body.linear_velocity * parameters.air_resistance)
	body.apply_central_force(Vector2.DOWN * parameters.gravity)
