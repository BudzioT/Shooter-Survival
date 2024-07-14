extends CharacterBody2D

# Update the Drone every frame
func _process(_delta):
	# Update its position
	_update()
	
# Update the drone
func _update():
	# Get its direction
	var direction = Vector2.RIGHT
	
	# Calculate the velocity
	velocity = direction * 400
	
	# Move it and slide when colliding
	move_and_slide()
	
# Handle hitting the drone
func hit() -> void:
	print("DRONE HIT")
	
