extends RigidBody2D


# Speed of the grenade
@export var speed : int = 400

# Explode the grenade
func explode():
	# Make explosion visible
	$Explosion.visible = true
	
	# Play the explosion animation
	$AnimationPlayer.play("Explosion")
