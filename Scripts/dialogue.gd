extends Label
var activated = false

func _ready():
	$"../Area2D".body_entered.connect(talk)
	$"../CanvasLayer/Button".pressed.connect(talk2)
	$"../CanvasLayer/Button2".pressed.connect(talk2)


func talk(body):
	if body is CharacterBody2D and not activated: #THIS WILL CAUSE BUGS LATER MOST LIKELY (IF IT WORKS IT WORKS)
		activated = true
		$"../StaticBody2D/CollisionShape2D".disabled = false
		
		await speak("HEY!\nLISTEN!");
		await speak("WHO IS IT\nTHAT PASSES");
		await speak("oh.\nhello little\nsnail.");
		await speak("can i have\nyour name?");
			
		$"../CanvasLayer".visible = true
		
		$"../StaticBody2D/CollisionShape2D".disabled = false
		$"../StaticBody2D2/CollisionShape2D".disabled = true

func talk2():
	$"../CanvasLayer".visible = false

func speak(words):
	await get_tree().create_timer(.1).timeout
	self.text = words
	self.visible_characters = 0
	while self.visible_characters < self.text.length():
			self.visible_characters += 1
			await get_tree().create_timer(.1).timeout
	await get_tree().create_timer(.4).timeout
	
