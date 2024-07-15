extends PathFollow2D


# Player near flag
var player_near: bool = false


# Process the car over frames
func _process(delta):
	# Move the car
	_move(delta)
	
# Handle car's movement
func _move(delta):
	# Increase car's position on the path
	progress_ratio += 0.02 * delta
	
	# If player is nearby
	if player_near:
		# Rotate the turret in his direction
		$Turret.look_at(Global.player_pos)

# Notice the player when he's entering the notice area
func _notice_area_body_entered(_body):
	player_near = true

# Leave the player alone when he exits the notice area
func _notice_area_body_exited(_body):
	player_near = false
