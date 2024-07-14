extends CanvasLayer


# Change current map to the given one
func change_map(path: String) -> void:
	# Play the transition
	$AnimationPlayer.play("BlackFade")
	# Wait for the animation to finish
	await($AnimationPlayer.animation_finished)
	
	# Change the scene
	get_tree().change_scene_to_file(path)
	
	# Play the reversed animation, to reveal the screen
	$AnimationPlayer.play_backwards("BlackFade")
