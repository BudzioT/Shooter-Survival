extends Node2D


# Scene with laser projectile
var laser_scene : PackedScene = preload("res://Scenes/Projectiles/Laser.tscn")
# Scene with grenade projectile
var grenade_scene : PackedScene = preload("res://Scenes/Projectiles/Grenade.tscn")


# Handle entering the gate
func _gate_entered(body):
	pass

# Handle exiting the gate
func _gate_exited(body):
	pass

# Make the player shoot a laser
func _used_main_action(pos, direction):
	# Create a laser instance
	var laser = laser_scene.instantiate()
	
	# Set its position
	laser.position = pos
	# Set the correct laser's rotation
	laser.rotation = direction.angle()
	# Update the direction
	laser.direction = direction
	
	# Add it to the current map's laser projectiles
	$Projectiles/Lasers.add_child(laser)

# Make the player throw a grenade
func _used_secondary_action(pos, direction):
	# Create the grenade
	var grenade = grenade_scene.instantiate()
	
	# Set position
	grenade.position = pos
	
	# Set velocity
	grenade.linear_velocity = direction * grenade.speed
	
	# Add it to the map's grenades
	$Projectiles/Grenades.add_child(grenade)
