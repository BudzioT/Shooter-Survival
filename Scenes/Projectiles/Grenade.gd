extends RigidBody2D


# Speed of the grenade
@export var speed: int = 400
# Explosion range
var explosion_range: int = 400

# Explosion flag
var explosion: bool = false


# Process the grenade changes
func _process(_delta):
	# If grenade is exploding
	if explosion:
		_handle_explosion()

# Explode the grenade
func explode() -> void:
	# Make explosion visible
	$Explosion.visible = true
	
	# Play the explosion animation
	$AnimationPlayer.play("Explosion")
	# Set the explosion flag to true
	explosion = true
	
# Handle the grenade's explosion
func _handle_explosion():
	# Get all the targets affected by explosion (containers and entities)
	var targets = get_tree().get_nodes_in_group("Container") \
	+ get_tree().get_nodes_in_group("Entity")
	
	# Go through each of them
	for target in targets:
		# Target is in explosion range flag
		var in_range = target.global_position.distance_to(global_position) < explosion_range
		
		# If target can be hit, and its in the range
		if "hit" in target and in_range:
			# Hit it
			target.hit()
