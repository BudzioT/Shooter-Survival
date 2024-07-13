extends CharacterBody2D


# Signals for player's actions
signal used_main_action(pos)
signal used_secondary_action

# Main and secondary allow action flags
var main_action: bool = true
var secondary_action: bool = true

# Update the player in every frame
func _process(delta):
	# Update player's position
	_update(delta)
	
	# Handle input
	_handle_input()
	
# Update player's position
func _update(_delta):
	# Get the player's direction vector
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	# Update his velocity
	velocity = direction * 400
	
	# Move the player, delta is applied automatically
	move_and_slide()
	
# Check for input and handle it
func _handle_input():
	# Check and handle main and secondary actions
	_main_action()
	_secondary_action()
	
# Shoot a  laser projectile from the weapon
func _main_action():
	# If player presses shoot action and is allowed to do it
	if Input.is_action_pressed("MainAction") and main_action:
		# Get position markers of the laser
		var positions = $Weapon.get_children()
		# Choose a random one
		var laser_marker = positions[randi() % positions.size()]
		
		# Don't allow player to use main action anymore
		main_action = false
		# Start the cooldown timer
		$MainTimer.start()
		
		# Emite the main action signal
		used_main_action.emit(laser_marker.position)

# Throw a grenade
func _secondary_action():
	# If user presses secondary action and is able to do it
	if Input.is_action_pressed("SecondaryAction") and secondary_action:
		# Turn off the flag
		secondary_action = false
		
		# Start the cooldown
		$SecondaryTimer.start()
		
		# Emit secondary action signal
		used_secondary_action.emit()

# When main action cooldown ends, allow the player to use it again
func _on_main_timer_timeout():
	main_action = true

# Allow the player to use secondary action after cooldown ends
func _on_secondary_timer_timeout():
	secondary_action = true
