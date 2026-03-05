extends RigidBody2D
class_name Player

@export var min_jet_force = 300
@export var max_jet_force = 1000
@export var force_curve: Curve
@export var max_speed = 1000
@export var stopping_force = Vector2.ONE * 5
