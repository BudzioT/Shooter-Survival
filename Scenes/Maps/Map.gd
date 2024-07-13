extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Change the logo's rotation
	$Logo.rotation_degrees += 45


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Increase Logos rotation
	$Logo.rotation_degrees += 100 * delta
	
	# Make sure it doesn't pass past 230
	if $Logo.rotation_degrees > 230:
		$Logo.rotation_degrees = 0
		
	# Make position stay at less than 1000 pixels horizontally
	if $Logo.position.x > 1000:
		$Logo.pos.x = 0
		
	# Store the press result of the left action
	var left = Input.is_action_pressed("Left")
	print(left)
