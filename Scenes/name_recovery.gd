extends Area2D

func _process(delta):
	$"Label".text = Gamemanager.fullname.substr(Gamemanager.currentname.length(),Gamemanager.currentname.length() + 1)

func _on_body_entered(body):
	$AudioStreamPlayer2D.play()
	var tween = get_tree().create_tween()
	tween.tween_property($"../BombLayer/ColorRect".material, 'shader_parameter/radius', 1, .5)
	$"../BombLayer/ColorRect".material.set_shader_parameter("radius",0)
	Gamemanager.currentname = Gamemanager.fullname.substr(0,Gamemanager.currentname.length() + 1)
	await get_tree().create_timer(.5).timeout
	queue_free()
