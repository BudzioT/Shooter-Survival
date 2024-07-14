extends Level


# Handle player entering the exit
func _exit_body_entered(_body) -> void:
	# Create a tween
	var tween = create_tween()
	# Set the player's speed to 0
	tween.tween_property($Player, "speed", 0, 1)
	
	# Move the player outside
	Transition.change_map("res://Scenes/Maps/Outside.tscn")
