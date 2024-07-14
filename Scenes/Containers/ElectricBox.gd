extends ItemContainer


# Handle electric box's hit
func hit() -> void:
	# Make sure box wasn't opened yet
	if not open:
		# Hide the lid
		$LidImage.hide()
		
		# Create 2 items
		for item_num in range(2):
			# Choose a random position marker
			var marker = $ItemSpawner.get_child(randi() % $ItemSpawner.get_child_count())
			
			# Emit proper signal
			lid_opened.emit(marker.global_position, item_direction)	
		# Set the open flag
		open = true
