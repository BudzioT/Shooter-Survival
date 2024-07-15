extends RigidBody2D


# Speed of the grenade
@export var speed : int = 400

# Explosion flag
var explosion: bool = false

# Explode the grenade
func explode() -> void:
	# Make explosion visible
	$Explosion.visible = true
	
	# Play the explosion animation
	$AnimationPlayer.play("Explosion")
	# Set the explosion flag to true
	explosion = true
