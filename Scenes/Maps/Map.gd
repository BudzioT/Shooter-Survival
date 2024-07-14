extends Node2D

# Name this class Level, for easier inheritance
class_name Level


# Scene with laser projectile
var laser_scene : PackedScene = preload("res://Scenes/Projectiles/Laser.tscn")
# Scene with grenade projectile
var grenade_scene : PackedScene = preload("res://Scenes/Projectiles/Grenade.tscn")
# Scene with item
var item_scene : PackedScene = preload("res://Scenes/Items/Item.tscn")


# Prepare the map
func _ready():
	# Go through each container and connect it's open signal to proper action
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("lid_opened", _container_opened)

# Make the player shoot a laser
func _used_main_action(pos, direction) -> void:
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
func _used_secondary_action(pos, direction) -> void:
	# Create the grenade
	var grenade = grenade_scene.instantiate()
	
	# Set position
	grenade.position = pos
	
	# Set velocity
	grenade.linear_velocity = direction * grenade.speed
	
	# Add it to the map's grenades
	$Projectiles/Grenades.add_child(grenade)
	
# Handle player opening a container
func _container_opened(pos, direction):
	# Create an item
	var item = item_scene.instantiate()
	
	# Set it at the correct position
	item.position = pos
	# Set its direction too
	item.direction = direction
	
	# Add it to one node for a clean look (deferred, so it doesn't mess with physics)
	$Items.call_deferred("add_child", item)
