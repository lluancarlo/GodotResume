extends SmartControl
class_name UIDebugMode


# NODES
#== DESKTOP
@onready var _desktop_fps_value : Label = $Desktop/HBox/Value
#== MOBILE
@onready var _mobile_fps_value : Label = $Desktop/HBox/Value


func _physics_process(_delta: float) -> void:
	if visible:
		update_fps(int(Engine.get_frames_per_second()))


func update_fps(value: int) -> void:
	var text = str(value)
	if super.get_is_mobile():
		_desktop_fps_value.text = text
	else:
		_mobile_fps_value.text = text
