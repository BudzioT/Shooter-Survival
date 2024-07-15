extends PathFollow2D


# Player near flag
var player_near: bool = false

# Save the laser lines
@onready var laser_line1: Line2D = $Turret/RayCast2D/Line2D
@onready var laser_line2: Line2D = $Turret/RayCast2D2/Line2D
# Get the fire animation nodes
@onready var fire1: Sprite2D = $Turret/FireAnimation/Fire1
@onready var fire2: Sprite2D = $Turret/FireAnimation/Fire2


# Process the car over frames
func _process(delta):
	# Move the car
	_move(delta)
	
# Handle car's movement
func _move(delta):
	# Increase car's position on the path
	progress_ratio += 0.03 * delta
	
	# If player is nearby
	if player_near:
		# Rotate the turret in his direction
		$Turret.look_at(Global.player_pos)

# Shoot the player	
func _shoot():
	# Decrease his health
	Global.health -= 20
	
	# Make the fire images appear
	fire1.modulate.a = 1
	fire2.modulate.a = 1
	
	# Create a parallel tween
	var tween = create_tween()
	tween.set_parallel(true)
	# Make the fire effects dissapear randomly
	tween.tween_property(fire1, "modulate:a", 0, randf_range(0.2, 0.6))
	tween.tween_property(fire2, "modulate:a", 0, randf_range(0.2, 0.6))

# Notice the player when he's entering the notice area
func _notice_area_body_entered(_body):
	# Set the flag
	player_near = true
	# Play the laser animation
	$AnimationPlayer.play("Laser")

# Leave the player alone when he exits the notice area
func _notice_area_body_exited(_body):
	# Reset the flag
	player_near = false
	# Stop the animation
	$AnimationPlayer.stop()
	
	# Create a parallel tween to set properties
	var tween = create_tween()
	tween.set_parallel(true)
	# Make the laser lines dissapear, by setting the width to 0. Do it with random duration
	tween.tween_property(laser_line1, "width", 0, randf_range(0.1, 0.5))
	tween.tween_property(laser_line2, "width", 0, randf_range(0.1, 0.5))
