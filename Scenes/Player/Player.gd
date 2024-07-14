extends CharacterBody2D


# Signals for player's actions
signal used_main_action(pos, direction)
signal used_secondary_action(pos, direction)
# Signal that stats have changed
signal stats_changed(type)

# Main and secondary allow action flags
var main_action: bool = true
var secondary_action: bool = true

# Max player's speed
@export var max_speed: int = 450
# His current speed
var speed: int = max_speed


# Update the player in every frame
func _process(delta):
	# Update player's position
	_update(delta)
	
	# Handle input
	_handle_input()
	
# Update player's position
func _update(_delta) -> void:
	# Get the player's direction vector
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	# Update his velocity
	velocity = direction * speed
	
	# Move the player, delta is applied automatically
	move_and_slide()
	
	# Rotate him based off the mouse position
	look_at(get_global_mouse_position())
	
# Check for input and handle it
func _handle_input() -> void:
	# Get the player's direction and normalize it
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	# Check and handle main and secondary actions
	_main_action(player_direction)
	_secondary_action(player_direction)
	
# Shoot a  laser projectile from the weapon
func _main_action(player_direction) -> void:
	# If player presses shoot action and is allowed to do it
	if Input.is_action_pressed("MainAction") and main_action:
		# If player has enough ammunition
		if Global.projectile_count > 0:
			# Subtract one projectile from the current count
			Global.projectile_count -= 1
			
			# Create some shooting particles
			$ShootParticle.emitting = true;
			
			# Get position markers of the laser
			var positions = $Weapon.get_children()
			
			# Choose a random one and store its position
			var pos = positions[randi() % positions.size()].global_position
			
			# Don't allow player to use main action anymore
			main_action = false
			# Start the cooldown timer
			$MainTimer.start()
		
			# Emite the main action signal
			used_main_action.emit(pos, player_direction)

# Throw a grenade
func _secondary_action(player_direction) -> void:
	# If user presses secondary action and is able to do it
	if Input.is_action_pressed("SecondaryAction") and secondary_action:
		# If player has any grenades left
		if Global.grenade_count > 0:
			# Subtract one grenade
			Global.grenade_count -= 1
			
			# Turn off the flag
			secondary_action = false
			# Start the cooldown
			$SecondaryTimer.start()
			
			# Get its marker position (choose a center one)
			var grenade_marker = $Weapon/LaserMarker2
			
			# Its position
			var pos = grenade_marker.global_position
			
			# Emit secondary action signal
			used_secondary_action.emit(pos, player_direction)

# When main action cooldown ends, allow the player to use it again
func _on_main_timer_timeout() -> void:
	main_action = true

# Allow the player to use secondary action after cooldown ends
func _on_secondary_timer_timeout() -> void:
	secondary_action = true
	
# Add item's powerup
func powerup(type : String) -> void:
	# If it's an ammo type, add ammunitions
	if type == "ammo":
		Global.projectile_count += 5
	# Otherwise if type is grenade, add 3 grenades
	elif type == "grenade":
		Global.grenade_count += 3
	# If it's a health type, increase player's health by 10, if it isn't max already
	elif type == "health":
		Global.health += 10
		
	# Emit signal that statistics have changed with the given type
	stats_changed.emit(type)
