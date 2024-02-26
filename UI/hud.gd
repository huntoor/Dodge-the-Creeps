extends CanvasLayer

signal start_game
	
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over!")

	# Wait for message timer
	await $MessageTimer.timeout

	$Message.text = "Dodge The Creeps!!"
	$Message.show()

	# Make one-shot timer and wait for it
	await get_tree().create_timer(0.5).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()