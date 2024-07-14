extends StaticBody2D

class_name ItemContainer


# Signal that informs that the container's lid was opened
signal lid_opened(pos, direction)

# Direction of the dropped item's
@onready var item_direction: Vector2 = Vector2.DOWN.rotated(rotation)

# Open flag
var open: bool = false
