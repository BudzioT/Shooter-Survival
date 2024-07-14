extends Area2D


# Speed of laser movement
@export var speed: int = 700
# Its direction
var direction: Vector2 = Vector2.UP


# Once object is created, handle proper initialization
func _ready():
	# Star the life timer
	$LifeTimer.start()

# Process the laser's changes
func _process(delta):
	# Update laser's position
	_update(delta)
	
# Update the laser
func _update(delta):
	# Move the laser
	position += direction * speed * delta
	

# Check and handle laser colliding with a body
func _body_entered(body) -> void:
	# If this was an enemy, hit it
	if "hit" in body:
		body.hit()
	
	# Destroy the laser
	queue_free()

# When laser's life timer ends, destroy it
func _life_timer_timeout() -> void:
	queue_free()
