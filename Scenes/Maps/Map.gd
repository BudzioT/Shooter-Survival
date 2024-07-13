extends Node2D


# Scene with laser projectile
var laser_scene = preload("res://Scenes/Projectiles/Laser.tscn")


# Handle entering the gate
func _gate_entered(body):
	pass

# Handle exiting the gate
func _gate_exited(body):
	pass

# Make the player shoot a laser
func _used_main_action(pos):
	# Create a laser instance
	var laser = laser_scene.instantiate()
	# Set its position
	laser.position = pos
	
	# Add it to the current map
	add_child(laser)

# Make the player throw a grenade
func _used_secondary_action():
	print("GRENADE")
