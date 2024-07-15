extends CharacterBody2D


# Player nearby flag
var player_near: bool = false
# Attack flag
var attack: bool = false

# Hunter's speed
var speed: int = 250


# Prepare the hunter
func _ready():
	# Get the path target position
	$NavigationAgent2D.target_position = Global.player_pos
	
# Process hunter's changes over frames
func _process(_delta):
	pass

# Make Hunter notice the player
func _notice_area_body_entered(_body):
	player_near = true

# Stop noticing the player
func _notice_area_body_exited(_body):
	player_near = false

# Attack the player
func _attack_area_body_entered(_body):
	attack = true

# Stop attacking the player
func _attack_area_body_exited(_body):
	attack = false
