extends StaticBody2D


# Signals for entering and exiting the gate
signal gate_entered(body)
signal gate_exited(body)

# Handle entering the gate
func _gate_area_entered(body):
	# Emit the signal that body entered the gate
	gate_entered.emit(body)

# Handle exiting the gate
func _gate_area_exited(body):
	# Emit gate exited signal
	gate_exited.emit(body)
