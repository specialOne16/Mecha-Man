extends Node
class_name PlayerMovement

@onready var node_2d: Node2D = $"../../Node2D"
@onready var player: Player = $"../.."

@export var dash_timer: Timer
@export var dash_cooldown_timer: Timer

@export_group("Actions")
@export var movement_aim: GUIDEAction
@export var movement_thrust: GUIDEAction
@export var movement_dash: GUIDEAction


var _direction: Vector2 = Vector2.RIGHT
var _constant_force: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if movement_aim.value_axis_2d != Vector2.ZERO: _direction = movement_aim.value_axis_2d.normalized()
	else: _direction = Vector2.UP * player.neutral_direction_force_scale
	node_2d.rotation = (-_direction).angle()
	
	_constant_force = Vector2.ZERO
	if dash_timer.time_left <= 0: _handle_jet()
	if _constant_force.normalized().y < -player.upward_gravity_threshold:
		player.gravity_scale = player.upward_gravity_scale
	else:
		player.gravity_scale = player.neutral_gravity_scale
	player.apply_central_force(_constant_force)
	
	_limit_speed()


func _ready() -> void:
	dash_timer.timeout.connect(_end_dash)
	movement_dash.just_triggered.connect(_start_dash)


func _start_dash():
	if dash_cooldown_timer.time_left > 0: return
	
	player.linear_velocity = Vector2.ZERO
	player.apply_central_impulse(player.dash_force * _direction)
	
	dash_timer.start(player.dash_duration)
	dash_cooldown_timer.start(player.dash_cooldown)


func _end_dash():
	dash_timer.stop()
	player.linear_velocity = player.linear_velocity * player.dash_end_momentum_scale


func _handle_jet():
	if movement_thrust.value_axis_1d > 0:
		var force = lerp(player.min_jet_force, player.max_jet_force, movement_thrust.value_axis_1d)
		var y_based_scale = player.force_curve.sample(_direction.y)
		_constant_force = _direction * force * y_based_scale
	else:
		var stopping_direction = -player.linear_velocity
		if stopping_direction.y < 0: stopping_direction.y = 0
		_constant_force = stopping_direction * player.stopping_force


func _limit_speed():
	if player.linear_velocity.length() > player.max_speed:
		player.linear_velocity = player.linear_velocity.normalized() * player.max_speed
