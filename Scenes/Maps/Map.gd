extends Node2D

# Name this class Level, for easier inheritance
class_name Level


# Scene with laser projectile
var laser_scene : PackedScene = preload("res://Scenes/Projectiles/Laser.tscn")
# Enemy projectiles
var enemy_laser_scene : PackedScene = preload("res://Scenes/Projectiles/EnemyLaser.tscn")

# Scene with grenade projectile
var grenade_scene : PackedScene = preload("res://Scenes/Projectiles/Grenade.tscn")
# Scene with item
var item_scene : PackedScene = preload("res://Scenes/Items/Item.tscn")


# Prepare the map
func _ready():
	# Go through each container and connect it's open signal to proper action
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("lid_opened", _container_opened)
	# Check and connect each shoot signal of the scouts
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("shoot", _scout_shoot)

# Make the player shoot a laser
func _used_main_action(pos, direction) -> void:
	# Create a laser instance
	var laser = laser_scene.instantiate()
	
	# Make the player shoot a laser
	_shoot_laser(pos, direction, laser)

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
	
# Shoot a laser and create it on the map
func _shoot_laser(pos, direction, laser) -> void:
	# Set its position
	laser.position = pos
	# Set the correct laser's rotation
	laser.rotation = direction.angle()
	# Update the direction
	laser.direction = direction
	
	# Add it to the current map's laser projectiles
	$Projectiles/Lasers.add_child(laser)
	
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
	
# Make the Scout shoot
func _scout_shoot(pos, direction) -> void:
	# Instantiate the Scout's laser
	var laser = enemy_laser_scene.instantiate()
	
	# Shoot it
	_shoot_laser(pos, direction, laser)
