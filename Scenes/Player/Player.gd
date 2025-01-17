extends CharacterBody2D


# Signals for player's actions
signal used_main_action(pos, direction)
signal used_secondary_action(pos, direction)

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
	# Store his new position in the global variables
	Global.player_pos = global_position
	
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
			
# Check and control player's damage
func hit() -> void:
	# Reduce player's health
	Global.health -= 10
	
	# Play the hit sound
	Global.player_hit_sound.play()
	
	# Make him different color for a while
	$PlayerImage.material.set_shader_parameter("filter", 1)
	# Wait for some time
	await get_tree().create_timer(0.2).timeout
	# Set his color back to normal
	$PlayerImage.material.set_shader_parameter("filter", 0)

# When main action cooldown ends, allow the player to use it again
func _on_main_timer_timeout() -> void:
	main_action = true

# Allow the player to use secondary action after cooldown ends
func _on_secondary_timer_timeout() -> void:
	secondary_action = true
