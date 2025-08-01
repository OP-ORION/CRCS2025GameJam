extends CharacterBody2D


@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		$SnailSprite.play("crawling")
		velocity.x = direction * SPEED
		$SnailSprite.scale.x = sign(direction)
	else:
		$SnailSprite.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
