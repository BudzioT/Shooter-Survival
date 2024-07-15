extends Node


# Signal that player's health has changed
signal health_changed
# Signal that projectile and grenade counts have changed
signal projectile_changed
signal grenade_changed

# Player's amount of projectiles
var projectile_count : int = 20:
	# Get the projectile count
	get:
		return projectile_count
	# Set the projectile count
	set(value):
		projectile_count = value
		# Emit signal that the projectile count has changed
		projectile_changed.emit()

# His grenade count
var grenade_count : int = 5:
	# Getter
	get:
		return grenade_count
	# Setter
	set(value):
		grenade_count = value
		# Emit proper signal
		grenade_changed.emit()

# Player's health
var health : int = 100:
	# Get the health
	get:
		return health
	# Set the health
	set(value):
		# If player healed, increase his health
		if health < value:
			# Make sure player's health doesn't exceed 100
			health += min(100, value)
		
		# Otherwise, if player is vulnerable
		elif player_vulnerable:
			# Set the new health
			health = value
			
			# Make him not vulnerable for a while
			player_vulnerable = false
			# Run the hit cooldown
			player_hit_cooldown()	
		# Emit the health changed signal
		health_changed.emit()
		
# Player's position
var player_pos: Vector2

# Player is vulnerable flag
var player_vulnerable: bool = true


# Control player's hit cooldown
func player_hit_cooldown():
	# Await for the cooldown to pass
	await get_tree().create_timer(0.5).timeout
	
	# Set him back to vulnerable
	player_vulnerable = true
