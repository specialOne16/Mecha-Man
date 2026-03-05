extends RigidBody2D
class_name Player

@export var max_speed = 1000
@export var stopping_force = Vector2.ONE * 5

@export_group("Jet")
@export var min_jet_force = 300
@export var max_jet_force = 1000
@export var force_curve: Curve
@export var neutral_direction_force_scale = 0.8

@export_group("Dash")
@export var dash_force = 1000
@export var dash_duration = 0.2
@export var dash_cooldown = 1.2
@export var dash_end_momentum_scale = 0.3
