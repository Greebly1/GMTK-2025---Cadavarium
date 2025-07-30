extends Node

@export var speed: float = 5.5


func process_movement(current_velocity: Vector3, player_basis: Basis, speed_multiplier: float) -> Vector3:
	var input_direction_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back")
	

	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y)
	

	var direction = player_basis * input_direction_3D
	
	current_velocity.x = direction.x * speed * speed_multiplier
	current_velocity.z = direction.z * speed * speed_multiplier
	
	
	
	return current_velocity
