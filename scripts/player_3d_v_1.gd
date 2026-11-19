extends CharacterBody3D


@export_range(0.0, 50.0, 0.1) var speed: float = 5.0
@export_range(0.0, 100.0, 0.1) var deceleration: float = 20.0

# Enable this on the player instance in scenes where jumping is allowed.
@export var can_jump: bool = false
@export_range(0.0, 30.0, 0.1) var jump_velocity: float = 4.5


func _physics_process(delta: float) -> void:
	# Gravity also applies in scenes where jumping is disabled.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if can_jump and is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity

	var input_dir := Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	# Movement follows the player's horizontal orientation.
	var camera: Camera3D = get_viewport().get_camera_3d()

	var forward: Vector3 = -camera.global_transform.basis.z
	var right: Vector3 = camera.global_transform.basis.x

	forward.y = 0.0
	right.y = 0.0
	forward = forward.normalized()
	right = right.normalized()

	var direction: Vector3 = (forward * -input_dir.y) + (right * input_dir.x).normalized()
	
	if not input_dir.is_zero_approx():
		velocity.x = direction.x * speed * input_dir.length()
		velocity.z = direction.z * speed * input_dir.length()
	else:
		velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)
		velocity.z = move_toward(velocity.z, 0.0, deceleration * delta)

	move_and_slide()
