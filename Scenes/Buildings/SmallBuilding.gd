extends Area2D


# Player's action signals
signal player_entered
signal player_left


# Emit a signal when body goes into the building
func _body_entered(_body) -> void:
	player_entered.emit()

# Emit proper signal when leaving the building
func _body_exited(_body) -> void:
	player_left.emit()
