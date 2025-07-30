extends CharacterBody3D


@onready var move_component: Node = %Move
@onready var crouch_component: Node = %Crouch
@onready var jump_component: Node = %Jump

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.2
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.2
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -80, 80)

	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var new_velocity = velocity
	var speed_multiplier = crouch_component.process_crouch(is_on_floor(), delta)
	print("On floor: ", is_on_floor())
	
	new_velocity = move_component.process_movement(new_velocity, self.transform.basis, speed_multiplier)
	new_velocity = jump_component.process_vertical_movement(new_velocity, is_on_floor(), delta)
	
	velocity = new_velocity
	move_and_slide()
	
