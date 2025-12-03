extends Camera3D

@export var zoom_distance: float = 1.0
@export var move_speed: float = 5.0

var default_position: Vector3
var target_position: Vector3

func _ready():
	default_position = global_position
	target_position = default_position

	# Ensure we correctly access the MainMenu node from the scene tree
	var ui = get_parent()
	if ui and ui.name == "MainMenu":
		for child in ui.get_children():
			if child is Button:
				child.mouse_entered.connect(_on_button_hover.bind(child))
				child.mouse_exited.connect(_on_button_exit)
	else:
		push_warning("MainMenu node not found as parent of Camera3D")

func _process(delta):
	global_position = global_position.lerp(target_position, delta * move_speed)

func _on_button_hover(button: Button):
	# Smooth zoom-in or move toward button target position if defined
	if button.has_meta("target_pos"):
		target_position = button.get_meta("target_pos")
	else:
		target_position = default_position + Vector3(0, 0, -zoom_distance)

func _on_button_exit():
	# Reset camera position smoothly when mouse leaves button
	target_position = default_position
