extends Node3D

# Attach this script to the MainMenu (or parent node of buttons)

@export var hover_scale: Vector2 = Vector2(1.2, 1.2)  # scale when hovered
@export var normal_scale: Vector2 = Vector2(1, 1)     # original scale
@export var tween_time: float = 0.2                   # animation speed

func _ready():
	# Connect signals for all Button children
	for button in get_children():
		if button is Button:
			# Make sure starting scale is normal
			button.scale = normal_scale
			button.mouse_entered.connect(_on_button_hovered.bind(button))
			button.mouse_exited.connect(_on_button_exited.bind(button))

func _on_button_hovered(button):
	var tween = button.create_tween()
	tween.tween_property(
		button,
		"scale",
		hover_scale,
		tween_time
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_button_exited(button):
	var tween = button.create_tween()
	tween.tween_property(
		button,
		"scale",
		normal_scale,
		tween_time
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
