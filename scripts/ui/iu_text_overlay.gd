extends Control
class_name UITextOverlay


# Configuration
@export var fade_duration := 0.5
# NODES
#== DESKTOP
@onready var _overlay_label: Label = $Label


func show_text(area_name: String, duration: float = 2.0) -> void:
	_overlay_label.text = area_name
	await create_tween().tween_property(_overlay_label, "modulate:a", 1.0, fade_duration).from(0.0).finished
	await get_tree().create_timer(duration).timeout
	await create_tween().tween_property(_overlay_label, "modulate:a", 0.0, fade_duration).from(1.0).finished
