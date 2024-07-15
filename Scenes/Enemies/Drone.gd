extends CharacterBody2D


# Player is near flag
var player_near: bool = false
# Vulnerability flag
var vulnerable: bool = true

# Drone's speed
var speed: int = 400
# Its health
var health: int = 50


# Update the Drone every frame
func _process(_delta):
	# Update its position
	_move()
	
# Move the drone
func _move():
	# If player is nearby, move closer to him
	if player_near:
		# Look at the player
		look_at(Global.player_pos)
		# Set its direction based off player's position
		var direction = (Global.player_pos - position).normalized()
		
		# Update drone's velocity and move it
		velocity = direction * speed
		move_and_slide()
	
# Handle hitting the drone
func hit() -> void:
	# Check if Drone is vulnerable
	if vulnerable:
		# If so, decrease its health
		health -= 10
	

# Set the player near flag when he's entering the notice area
func _notice_area_body_entered(body):
	player_near = true

# Reset player near flag when exiting the notice area
func _notice_area_body_exited(body):
	player_near = false
