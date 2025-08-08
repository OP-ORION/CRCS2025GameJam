extends Camera2D

func _physics_process(delta: float) -> void:
	self.global_position = Vector2($"..".global_position.x - fposmod($"..".global_position.x ,1),$"..".global_position.y - fposmod($"..".global_position.y ,1))
