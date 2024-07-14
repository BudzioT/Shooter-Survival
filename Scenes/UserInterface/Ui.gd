extends CanvasLayer


# Health bar
@onready var healthbar: TextureProgressBar = $HealthBar/TextureProgressBar

# Current projectile label
@onready var projectile_label: Label = $Projectiles/VBoxContainer/Label
# Current grenade label
@onready var grenade_label: Label = $Grenades/VBoxContainer/Label

# Projectile and grenade icons
@onready var projectile_icon: TextureRect = $Projectiles/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $Grenades/VBoxContainer/TextureRect

# Colors of user's interface
const green: Color = Color("334D36")
const red: Color = Color("A12020")


# Get the user's interface ready
func _ready():
	# Update the health
	update_health_bar()
	# Connect health change signal to the update function, so the bar always updates
	Global.connect("health_changed", update_health_bar)
	
	# Set the projectile and grenade count labels
	update_projectile_label()
	update_grenade_label()

# Update the projectile's count
func update_projectile_label() -> void:
	projectile_label.text = str(Global.projectile_count)
	# Set the color of icon and label
	_set_color(Global.projectile_count, projectile_label, projectile_icon)
	
# Update player's grenade's count
func update_grenade_label() -> void:
	grenade_label.text = str(Global.grenade_count)
	# Set the proper color
	_set_color(Global.grenade_count, grenade_label, grenade_icon)
	
# Update player's health bar
func update_health_bar() -> void:
	healthbar.value = Global.health
	
# Set the color of given label, icon depending on given count
func _set_color(count: int, label: Label, icon: TextureRect) -> void:
	# If count is higher than 0, set the colors to green
	if count > 0:
		label.modulate = green
		icon.modulate = green
	# Otherwise set it to red
	else:
		label.modulate = red
		icon.modulate = red
