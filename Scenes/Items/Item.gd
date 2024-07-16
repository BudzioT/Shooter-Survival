extends Area2D


# Rotation speed of the item
var rotation_speed: int = 5

# Type of items available (ammunition gets the highest chance to be chosen)
var types = ["ammo", "ammo", "ammo", "ammo", "ammo", "grenade", "health"]
# This item's type, chosen randomly
var type : String = types[randi() % len(types)]

# Item colors
const ammo_color : Color = Color("2DB5C4")
const grenade_color : Color = Color("2E362C")
const health_color : Color = Color("E02B1B")

# Direction of the item
var direction: Vector2
# Its distance from the origin (randomly chosen)
var distance: int = randi_range(150, 250)


# Prepare the item
func _ready():
	# Set the color based off the type
	if type == "ammo":
		$Sprite2D.modulate = ammo_color
	elif type == "grenade":
		$Sprite2D.modulate = grenade_color
	elif type == "health":
		$Sprite2D.modulate = health_color
		
	# Calculate final position
	var final_position = position + direction * distance
	
	# Create a tween
	var tween = create_tween()
	# Make it parallel
	tween.set_parallel(true)
	
	# Move the item with the created twin
	tween.tween_property(self, "position", final_position, 0.5)
	# Add appearing effect on the item
	tween.tween_property(self, "scale", Vector2(1, 1), 0.35).from(Vector2(0, 0))
		
# Process the item's changes
func _process(delta):
	# Rotate it
	rotation += rotation_speed * delta

# Handle player going into an item
func _body_entered(_body):
	# Add item's powerup to the player
	# If it's an ammo type, add ammunitions
	if type == "ammo":
		Global.projectile_count += 5
	# Otherwise if type is grenade, add 3 grenades
	elif type == "grenade":
		Global.grenade_count += 3
	# If it's a health type, increase player's health by 10, if it isn't max already
	elif type == "health":
		Global.health += 10
		
	# Hide the item, so it doesn't stay when sound effect plays
	$Sprite2D.hide()
	# Play the collect sound
	$Sound.play()
	# Await for the sound to finish
	await $Sound.finished
		
	# Destroy the item
	queue_free()
