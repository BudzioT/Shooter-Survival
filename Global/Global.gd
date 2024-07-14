extends Node


# Signal that player's health has changed
signal health_changed
# Signal that projectile and grenade counts have changed
signal projectile_changed
signal grenade_changed

# Player's amount of projectiles
var projectile_count : int = 20:
	# Get the projectile count
	get:
		return projectile_count
	# Set the projectile count
	set(value):
		projectile_count = value
		# Emit signal that the projectile count has changed
		projectile_changed.emit()

# His grenade count
var grenade_count : int = 5:
	# Getter
	get:
		return grenade_count
	# Setter
	set(value):
		grenade_count = value
		# Emit proper signal
		grenade_changed.emit()

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
