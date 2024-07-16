extends CharacterBody2D


# Player is nearby flag
var player_near: bool = false
# Scout can shoot flag
var can_shoot: bool = false
# Scout can be hit flag
var vulnerable: bool = true

# Flag indicating gun to shoot with (false - left, true - right)
var gun: bool = false

# Health of the scout
var health: int = 50

# Signal to shoot
signal shoot(pos, direction)


# Process Scout's changes
func _process(_delta):
	# Update the Scout if player is near
	if player_near:
		# Update him
		_update()
	
# Update scout's position
func _update():
	# Look at the player
	look_at(Global.player_pos)
	
	# Shoot if needed
	_shoot()
	
# Shoot the player if possible
func _shoot():
	# If enemy can shoot
	if can_shoot:
		# Emit some particle based off the current gun
		$ShootParticles.get_child(gun).emitting = true
		
		# Get the current gun's position
		var pos = $LaserSpawners.get_child(gun).global_position
		# Change the gun
		gun = not gun
		# Calculate the laser's direction
		var direction: Vector2 = (Global.player_pos - position).normalized()
		
		# Emit signal to shoot
		shoot.emit(pos, direction)
		
		# Turn off the shoot flag
		can_shoot = false
		# Start the cooldown
		$Timers/ShootCooldown.start()
		
# Handle scout getting hit
func hit() -> void:
	# If enemy is vulnerable
	if vulnerable:
		# Decrease his health
		health -= 10
		
		# Set him to not vulnerable
		vulnerable = false
		# Start the hit cooldown timer
		$Timers/HitCooldown.start()
		
		# Make him different color, to show the user that he damaged the scout
		$Image.material.set_shader_parameter("progress", 1)
		# Play the hit sound effect
		$Sound.play()
		
		# If he doesn't have health anymore, kill him
		if health <= 0:
			queue_free()
	
# Handle player entering the scout's attack range
func _attack_area_body_entered(_body):
	# Change the player near flag to true
	player_near = true

# Handle player leaving the attack range
func _attack_area_body_exited(_body):
	# Reset the player nearby flag
	player_near = false

# Handle the shoot cooldown
func _shoot_cooldown_timeout():
	# Allow enemy to shoot on cooldown end
	can_shoot = true

# Manipulate the hit cooldown
func _hit_cooldown_timeout():
	# Allow enemy to take damage
	vulnerable = true
	$Image.material.set_shader_parameter("progress", 0)
