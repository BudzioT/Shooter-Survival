extends ItemContainer


# Handle Toilet's hits
func hit() -> void:
	# If toilet wasn't opened yet, open it
	if not open:
		# Hide the lid
		$LidImage.hide()
		# Play the container hit sound
		$Sound.play()
		
		# Get the position of the item
		var pos = $ItemSpawner/Marker2D.global_position
		
		# Emit signal that the toilet has been opened
		lid_opened.emit(pos, item_direction)
		# Turn off the open flag
		open = true
