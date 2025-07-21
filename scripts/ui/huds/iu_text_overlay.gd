extends Control
class_name UITextOverlay


# Configuration
@export var fade_duration := 0.5
# NODES
#== DESKTOP
@onready var _desktop_label: Label = $DesktopLabel
#== MOBILE
@onready var _mobile_label: Label = $MobileLabel


func _ready() -> void:
	if GameData.isMobile:
		_desktop_label.queue_free()
	else:
		_mobile_label.queue_free()


func show_text(area_name: String, duration: float = 2.0) -> void:
	var label = _desktop_label if is_instance_valid(_desktop_label) else _mobile_label
	label.text = area_name
	await create_tween().tween_property(label, "modulate:a", 1.0, fade_duration).from(0.0).finished
	await get_tree().create_timer(duration).timeout
	await create_tween().tween_property(label, "modulate:a", 0.0, fade_duration).from(1.0).finished
