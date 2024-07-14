extends Area2D


# Speed of laser movement
@export var speed: int = 700
# Its direction
var direction: Vector2 = Vector2.UP

# Process the laser's changes
func _process(delta):
	# Update laser's position
	_update(delta)
	
# Update the laser
func _update(delta):
	# Move the laser
	position += direction * speed * delta
	

# Check and handle laser colliding with a body
func _body_entered(body):
	# Destroy the laser
	queue_free()
