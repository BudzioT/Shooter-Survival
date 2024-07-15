extends CharacterBody2D


# Player is near flag
var player_near: bool = false
# Vulnerability flag
var vulnerable: bool = true
# Explosion active flag
var explosion: bool = false

# Drone's speed
var speed: int = 0
# Its max speed
var max_speed: int = 600
# Speed multiplier to prevent moving after death
var speed_multiplier: int = 1

# Drone's explosion radius
var explosion_radius: int = 400
# Its health
var health: int = 50


# Prepare the drone
func _ready():
	# Show the drone
	$Image.show()
	# Hide the explosion animation
	$Explosion.hide()


# Update the Drone every frame
func _process(delta):
	# Update its position
	_move(delta)
	
# Move the drone
func _move(delta):
	# If player is nearby, move closer to him
	if player_near:
		# Look at the player
		look_at(Global.player_pos)
		# Set its direction based off player's position
		var direction = (Global.player_pos - position).normalized()
		
		# Update drone's velocity and move it
		velocity = direction * speed * speed_multiplier
		# Store the collision
		var collision = move_and_collide(velocity * delta)
		
		# If there was collision, play the explosion and kill the drone
		if collision:
			$AnimationPlayer.play("Explosion")
			# Set the explosion flag
			explosion = true
					
	# If there is an explosion, make it hurt other entities and objects
	if explosion == true:
		_explode()
	
# Handle hitting the drone
func hit() -> void:
	# Check if Drone is vulnerable
	if vulnerable:
		# If so, decrease its health
		health -= 10
		# Make him blink
		$Image.material.set_shader_parameter("filter", 1.0)
		
		# Set its vulnerability back to false
		vulnerable = false
		# Start the hit cooldown
		$Timers/HitTimer.start()
		
		# Kill it, if it doesn't have any more health
		if health <= 0:
			# Play the explosion animation, while killing the drone
			$AnimationPlayer.play("Explosion")
			# Exlplode
			explosion = true
	
# Stop drone's movement		
func _stop_movement():
	speed_multiplier = false
	
# Explode the drone and hurt other affected nodes
func _explode():
	# Get all targeted nodes
		var targets = get_tree().get_nodes_in_group("Container") \
		+ get_tree().get_nodes_in_group("Entity")
		
		# Go through each of them
		for target in targets:
			# Check if the target is in range of explosion
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			# Make sure the target can be hit and is in range
			if in_range and "hit" in target:
				# Hit it
				target.hit()

# Set the player near flag when he's entering the notice area
func _notice_area_body_entered(_body):
	player_near = true
	
	# Create a tween, increase the drone's speed up to max one, during 6 seconds
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)

# Reset player near flag when exiting the notice area
func _notice_area_body_exited(_body):
	player_near = false

# Handle hit cooldown
func _hit_timer_timeout():
	vulnerable = true
	# Stop blinking
	$Image.material.set_shader_parameter("filter", 0)
