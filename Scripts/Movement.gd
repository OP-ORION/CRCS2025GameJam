extends RigidBody2D


@export var SPEED := 300.0
@export var ROLL_SPEED := 300.0
@export var JUMP_VELOCITY := -400.0
var reloading = false
var canJump = false

func _ready() -> void:
	$Camera2D/AnimationPlayer.play("Zoom_In")

func _physics_process(delta: float) -> void:

	# Handle jump.
	$RayCast2D.force_raycast_update()
	if Input.is_action_just_pressed("Up") and $RayCast2D.is_colliding() and lock_rotation:
		$RollMin.start()
		lock_rotation = false
		apply_force(Vector2(0,JUMP_VELOCITY))

	var direction := Input.get_axis("Left", "Right")
	if direction:
		$SnailSprite.play("crawling")
		constant_force = Vector2(direction*SPEED * (1 if lock_rotation else 0),0)
		apply_torque(ROLL_SPEED*direction * (0 if lock_rotation else 1))
		$SnailSprite.scale.x = sign(direction) if lock_rotation else 1
	else:
		constant_force = Vector2(0,0)
		$SnailSprite.stop()
	
	#slow to a snails pace
	if (linear_velocity.abs().x > 100) and lock_rotation:
		linear_velocity.x = 100 * linear_velocity.sign().x
	
	
	if (linear_velocity.abs().length()<25) and $RollMin.is_stopped() and not direction:
		lock_rotation = true
		rotation = 0
	
	if position.y > 1000 and not reloading:
		reloading = true
		$Camera2D/AnimationPlayer.play("Zoom_Out")
		await $Camera2D/AnimationPlayer.animation_finished
		print(get_tree())
		get_tree().reload_current_scene()
