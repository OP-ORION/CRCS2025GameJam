extends RigidBody2D


@export var Accelleration := 300.0
@export var ROLL_SPEED := 300.0
@export var JUMP_VELOCITY := -400.0
@export var Max_Speed := -400.0
@export var Normal_Mass := 1
@export var Roll_Mass := 5
var reloading = false
var canJump = false

func _ready() -> void:
	$Camera2D/AnimationPlayer.play("Zoom_In")

func _physics_process(delta: float) -> void:

	# Handle jump.
	$RayCast2D.force_raycast_update()
	if Input.is_action_just_pressed("Up") and lock_rotation:
		$RollMin.start()
		mass = Roll_Mass
		lock_rotation = false
		apply_force(Vector2(0,JUMP_VELOCITY if canJump and $RayCast2D.is_colliding() else 0))
		$SnailSprite.play("rolling")
	
	#handle move
	var direction := Input.get_axis("Left", "Right")
	if direction:
		if (lock_rotation):
			$SnailSprite.play("crawling")
			constant_force = Vector2(direction*Accelleration,0)
			$SnailSprite.scale.x = sign(direction)
		else:
			apply_torque(ROLL_SPEED*direction )
	else:
		constant_force = Vector2(0,0)
		if lock_rotation: $SnailSprite.stop()
	
	#slow to a snails pace
	if (linear_velocity.abs().x > Max_Speed) and lock_rotation:
		linear_velocity.x = Max_Speed * linear_velocity.sign().x
	
	#handle stop rolling
	if (linear_velocity.abs().length()<25) and $RollMin.is_stopped() and not direction:
		mass = Normal_Mass
		lock_rotation = true
		$SnailSprite.play("crawling")
		rotation = 0
	
	if position.y > 1000 and not reloading:
		reloading = true
		$Camera2D/AnimationPlayer.play("Zoom_Out")
		await $Camera2D/AnimationPlayer.animation_finished
		get_tree().reload_current_scene()
