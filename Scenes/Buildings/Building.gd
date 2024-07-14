extends Area2D


# Signal informing that player has entered the building
signal player_entered
signal player_left

# Handle entering the building by a body
func _body_entered(_body) -> void:
	# Emit the proper singnal
	player_entered.emit()

# Handle body exiting the building
func _body_exited(_body) -> void:
	# Emit the signal
	player_left.emit()
