extends CharacterBody2D


# Player is near flag
var player_near: bool = false
# Player is in the attack range flag
var attack: bool = false
# Vulnerability flag
var vulnerable: bool = true

# Bug's health
var health: int = 30
# Its speed
var speed: int = 500

# Process the Bug's changes
func _process(delta):
	_move(delta)
	
# Make the Bug move
func _move(_delta):
	# If player is near, move closer to him
	if player_near:
		# Make his movement direction point to the player
		var direction = (Global.player_pos - global_position).normalized()
		# Update the velocity
		velocity = direction * speed
			
		move_and_slide()
		# Look at the player
		look_at(Global.player_pos)
	
# Handle hitting the Bug	
func hit():
	# Make sure bug is vulnerable
	if vulnerable:
		# Make him invincible for a while
		vulnerable = false
		# Decrease his health
		health -= 10
		# Start the hit cooldown
		$Timers/HitCooldown.start()
		
		# Change the shader color to indicate damage
		$Animation.material.set_shader_parameter("filter", 1.0)
		# Emit some particles
		$Particles/HitParticles.emitting = true
		
		# Make Bug dissapear after killing it
		if health <= 0:
			queue_free()

# Handle player entering the bug's notice area
func _notice_area_body_entered(_body):
	# Set the player is nearby flag
	player_near = true
	# Start the walk animation
	$Animation.play("walk")
	
# Handle player exiting the notice area
func _notice_area_body_exited(_body):
	# Reset the notice flag
	player_near = false
	# Stop playing the walk animation
	$Animation.stop()

# Control player getting into the attack area
func _attack_area_body_entered(_body):
	# Set the attack flag to true
	attack = true
	# Play attack animation
	$Animation.play("attack")

# Control player leaving attack area
func _attack_area_body_exited(_body):
	# Turn off the attack flag
	attack = false

# Handle actions when attack animation finishes
func _animation_finished():
	# If enemy is in attack state
	if attack:
		# Decrease the player's health
		Global.health -= 10
		# Start the attack cooldown
		$Timers/AttackCooldown.start()

# Make the Bug able to attack after cooldown passes
func _attack_cooldown_timeout():
	# Play the attack animation, restarting the attack cycle
	$Animation.play("attack")

# Make enemy vulnerable after cooldown ended
func _hit_cooldown_timeout():
	# Make the enemy vulnerable again
	vulnerable = true
	# Revert Bug's color
	$Animation.material.set_shader_parameter("filter", 0)
