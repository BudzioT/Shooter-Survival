extends Node2D


# Scene with laser projectile
var laser_scene : PackedScene = preload("res://Scenes/Projectiles/Laser.tscn")
# Scene with grenade projectile
var grenade_scene : PackedScene = preload("res://Scenes/Projectiles/Grenade.tscn")


# Handle entering the gate
func _gate_entered(_body):
	# Create a tween
	var tween = create_tween()
	# Set player's speed to 0
	tween.tween_property($Player, "speed", 0, 0.5)

# Handle exiting the gate
func _gate_exited(_body):
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


# Handle player entering a building
func _building_player_entered():
	# Create a tween in the map's nodes tree and store it
	var tween = get_tree().create_tween()
	# Set parallel on tween to true
	tween.set_parallel(true)
	
	# Set the player's zoom to a bigger one
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.7, 0.7), 2)
	# Decrease his alpha a little
	tween.tween_property($Player, "modulate:a", 0.4, 2)

# Handle player exiting the building
func _on_building_player_left():
	# Get the tween
	var tween = get_tree().create_tween()
	# Set tween to make changes in parallel
	tween.set_parallel(true)
	# Set player's zoom back to normal
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5, 0.5), 2)
	# Set his alpha back to normal
	tween.tween_property($Player, "modulate:a", 1, 2)

# Handle player entering small building
func _small_building_player_entered():
	# Set the player's camera zoom property to a closer one and alpha to smaller one in parallel
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.8, 0.8), 3)
	tween.tween_property($Player, "modulate:a", 0.4, 3)

# Handle player leaving a small building
func _small_building_player_left():
	# Revert player's zoom and alpha back to normal, doing it at the same time
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5, 0.5), 3)
	tween.tween_property($Player, "modulate:a", 1, 3)
