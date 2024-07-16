extends CharacterBody2D


# Player nearby flag
var player_near: bool = false
# Attack flag
var attack: bool = false

# Hunter's speed
var speed: int = 250


# Prepare the hunter
func _ready():
	# Get the path target position
	$NavigationAgent2D.target_position = Global.player_pos
	
# Process hunter's physics-related changes over frames
func _physics_process(_delta):
	# If player is nearby
	if player_near:
		# Get the next path position
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
	
		# Calculate direction of the Hunter, based off next path position
		var direction : Vector2 = (next_path_pos - global_position).normalized()
		# Set the velocity to the given direction
		velocity = direction * speed
		
		# Move the Hunter
		move_and_slide()
		
		# Look at the player
		var look_angle = direction.angle()
		rotation = look_angle + PI / 2

# Make Hunter notice the player
func _notice_area_body_entered(_body):
	player_near = true
	# Play the walk animation
	$AnimationPlayer.play("Walk")

# Stop noticing the player
func _notice_area_body_exited(_body):
	player_near = false

# Attack the player
func _attack_area_body_entered(_body):
	attack = true
	# Play the attack animation
	$AnimationPlayer.play("Attack")

# Stop attacking the player
func _attack_area_body_exited(_body):
	attack = false

# Handle navigation timer timing out
func _navigation_timer_timeout():
	# If Hunter is seeing the player
	if player_near:
		# Update the target path position
		$NavigationAgent2D.target_position = Global.player_pos
