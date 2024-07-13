extends Sprite2D

# Position of Icon
var pos: Vector2 = Vector2.ZERO
# Its speed
const speed: int = 100

# Its scale
var test_scale: int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set the position
	position = Vector2(300, 200)
	position = pos
	
	# Assign a new rotation
	var test_rotation = 45
	# Save it
	rotation_degrees = test_rotation
	
	# Scale the Icon up by two times
	test_scale = 2
	# Assign it
	scale = Vector2(test_scale, test_scale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Move the Icon depending on the speed
	pos.x += speed * delta
	# Save the position
	position = pos
	
	## Set scale
	#test_scale += 1
	## Save it
	#scale = Vector2(test_scale, test_scale)
