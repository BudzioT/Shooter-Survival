extends ItemContainer


# Handle hitting the crate
func hit() -> void:
	# Hide the lid
	$LidImage.hide()
	
	# Choose a random position marker
	var marker = $ItemSpawner.get_child(randi() % $ItemSpawner.get_child_count())
	
	# Emit signal that the lid has been opened
	lid_opened.emit(marker.global_position, item_direction)
