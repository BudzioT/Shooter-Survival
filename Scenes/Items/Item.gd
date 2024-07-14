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


# Prepare the item
func _ready():
	# Set the color based off the type
	if type == "ammo":
		$Sprite2D.modulate = ammo_color
	elif type == "grenade":
		$Sprite2D.modulate = grenade_color
	elif type == "health":
		$Sprite2D.modulate = health_color
		
# Process the item's changes
func _process(delta):
	# Rotate it
	rotation += rotation_speed * delta

# Handle player going into an item
func _body_entered(body):
	# Add item's powerup to the player
	body.powerup(type)
	# Destroy the item
	queue_free()
