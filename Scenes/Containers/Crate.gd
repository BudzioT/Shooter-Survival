extends ItemContainer


# Handle hitting the crate
func hit() -> void:
	# Hide the lid
	$LidImage.hide()
	
	# Spawn 4 items
	for item_num in range(5):
		# Choose a random position marker
		var marker = $ItemSpawner.get_child(randi() % $ItemSpawner.get_child_count())
		
		# Emit signal that the lid has been opened
		lid_opened.emit(marker.global_position, item_direction)
