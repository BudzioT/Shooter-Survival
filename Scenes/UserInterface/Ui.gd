extends CanvasLayer


# Current projectile label
@onready var projectile_label: Label = $Projectiles/VBoxContainer/Label
# Current grenade label
@onready var grenade_label: Label = $Grenades/VBoxContainer/Label


# Get the user's interface ready
func _ready():
	# Set the projectile and grenade count labels
	update_projectile_label()
	update_grenade_label()

# Update the projectile's count
func update_projectile_label():
	projectile_label.text = str(Global.projectile_count)
	
# Update player's grenade's count
func update_grenade_label():
	grenade_label.text = str(Global.grenade_count)
