extends CharacterBody2D

@export var max_speed: float = 300.0
@export var acceleration: float = 1500.0
@export var friction: float = 1200.0
@export var jump_velocity: float = -450.0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# 1. Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# 2. Handle Jumping (Uses "ui_accept" which is Spacebar by default)
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = jump_velocity

	# 3. Get Horizontal Input (-1 for Left, 1 for Right, 0 for None)
	var direction := Input.get_axis("Left", "Right")
	
	# 4. Apply Acceleration or Friction
	if direction != 0:
		# Gradually speed up toward the target direction
		velocity.x = move_toward(velocity.x, direction * max_speed, acceleration * delta)
	else:
		# Gradually slow down to a stop when no keys are pressed
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	# 5. Execute Movement
	move_and_slide()
