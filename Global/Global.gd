extends Node


# Signal that player's health has changed
signal health_changed

# Player's amount of projectiles
var projectile_count : int = 20
# His grenade count
var grenade_count : int = 5

# Player's health
var health : int = 100:
	# Get the health
	get:
		return health
	
	# Set the health
	set(value):
		health = value
		# Emit the health changed signal
		health_changed.emit()
