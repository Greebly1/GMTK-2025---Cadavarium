extends Node

@export var gravity: float = 25.0
@export var jump_force: float = 10.0
@export var fall_multiplier: float = 0

func process_vertical_movement(current_velocity: Vector3, is_on_floor: bool, delta: float) -> Vector3:

	if not is_on_floor:
		current_velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor:
		current_velocity.y = jump_force

	elif Input.is_action_just_released("jump") and current_velocity.y > 0.0:
		current_velocity.y = fall_multiplier 

	return current_velocity
