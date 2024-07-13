extends CharacterBody2D

# Update the player in every frame
func _process(delta):
	# Update player's position
	_update(delta)
	
	# Shoot the laser when needed
	_main_action()
	
# Update player's position
func _update(_delta):
	# Get the player's direction vector
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	# Update his velocity
	velocity = direction * 400
	
	# Move the player, delta is applied automatically
	move_and_slide()
	
# Shoot a  laser projectile from the weapon
func _main_action():
	# If player presses shoot action
	if Input.is_action_pressed("MainAction"):
		print("Laser")

# Throw a grenade
func _secondary_action():
	# If user presses secondary action
	if Input.is_action_pressed("SecondaryAction"):
		print("Grenade")
