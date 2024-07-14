extends Level


# Handle entering the gate
func _gate_entered(_body):
	# Create a tween
	var tween = create_tween()
	# Set player's speed to 0
	tween.tween_property($Player, "speed", 0, 0.5)
