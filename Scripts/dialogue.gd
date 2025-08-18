extends Label
var activated = false

func _ready():
	$"../Area2D".body_entered.connect(talk)
	$"../CanvasLayer/Button".pressed.connect(talk2)
	$"../CanvasLayer/Button2".pressed.connect(talk2)


func talk(body):
	if body == $"../../Snail" and not activated: #THIS WILL CAUSE BUGS LATER MOST LIKELY (IF IT WORKS IT WORKS)
		activated = true
		$"../StaticBody2D/CollisionShape2D".disabled = false
		$"../AnimationPlayer".play("FlyOn")
		await get_tree().create_timer(.5).timeout
		
		await speak("HEY!\nLISTEN!");
		await speak("WHO IS IT\nTHAT PASSES");
		await speak("oh.\nhello little\nsnail.");
		await speak("can i have\nyour name?");
			
		$"../CanvasLayer".visible = true
	

func talk2():
	$"../AudioStreamPlayer2D".play()
	var tween = get_tree().create_tween()
	tween.tween_property($"../../BombLayer/ColorRect".material, 'shader_parameter/radius', 5, 2.5)
	$"../CanvasLayer".visible = false
	Gamemanager.currentname = ""
	await speak("FOOLISH MORTAL!");
	await speak("HERE. IN MY\n PITTY");
	await speak("I WILL GIVE YOU\n THE ABILITY\n TO JUMP");
	$"../../Snail".canJump = true
	await speak("");
	$"../AnimationPlayer".play("FlyOff")
	$"../StaticBody2D/CollisionShape2D".disabled = false
	$"../StaticBody2D2/CollisionShape2D".disabled = true


func speak(words):
	await get_tree().create_timer(.1).timeout
	self.text = words
	self.visible_characters = 0
	while self.visible_characters < self.text.length():
			self.visible_characters += 1
			await get_tree().create_timer(.1).timeout
	await get_tree().create_timer(.4).timeout
	
