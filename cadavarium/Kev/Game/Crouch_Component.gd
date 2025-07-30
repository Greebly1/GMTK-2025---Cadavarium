extends Node

@export var collision_shape: CollisionShape3D
@export var camera: Camera3D
@export var stand_up_check: ShapeCast3D

@export var standing_height: float = 2.0
@export var crouching_height: float = 1.0
@export var crouch_speed_multiplier: float = 0.5
@export var transition_speed: float = 10.0

var is_crouching: bool = false


func process_crouch(is_on_floor: bool, delta: float) -> float:
	var crouch_input_held = Input.is_action_pressed("crouch") and is_on_floor


	if crouch_input_held:
		is_crouching = true
		print("Crouching")
	elif not is_obstructed():
		print("Not Crouching")
		is_crouching = false
		
	var target_height = standing_height if not is_crouching else crouching_height

	collision_shape.shape.height = lerp(collision_shape.shape.height, target_height, delta * transition_speed)
	camera.position.y = lerp(camera.position.y, target_height, delta * transition_speed)

	return crouch_speed_multiplier if is_crouching else 1.0


func is_obstructed() -> bool:
	stand_up_check.force_shapecast_update()
	return stand_up_check.is_colliding()
