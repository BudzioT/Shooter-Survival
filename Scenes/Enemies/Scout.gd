extends CharacterBody2D


# Player is nearby flag
var player_near: bool = false
# Scout can shoot flag
var can_shoot: bool = false

# Signal to shoot
signal shoot(pos, direction)

# Process Scout's changes
func _process(_delta):
	# Update the Scout if player is near
	if player_near:
		_update()
		print("ATTACK!")
	
# Update scout's position
func _update():
	# Look at the player
	look_at(Global.player_pos)
	
# Handle player entering the scout's attack range
func _attack_area_body_entered(body):
	# Change the player near flag to true
	player_near = true

# Handle player leaving the attack range
func _attack_area_body_exited(body):
	# Reset the player nearby flag
	player_near = false
