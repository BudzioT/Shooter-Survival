extends CharacterBody2D


# Player is near flag
var player_near: bool = false
# Player is in the attack range flag
var attack: bool = false
# Vulnerability flag
var vulnerable: bool = true

# Its speed
var speed: int = 470


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

# Handle player entering the bug's notice area
func _notice_area_body_entered(_body):
	# Set the player is nearby flag
	player_near = true
	
# Handle player exiting the notice area
func _notice_area_body_exited(_body):
	print("LEFT")
	# Reset the notice flag
	player_near = false

# Control player getting into the attack area
func _attack_area_body_entered(_body):
	# Set the attack flag to true
	attack = true

# Control player leaving attack area
func _attack_area_body_exited(_body):
	# Turn off the attack flag
	attack = false
