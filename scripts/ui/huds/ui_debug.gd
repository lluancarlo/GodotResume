extends Control
class_name UIDebug


# NODES
#== DESKTOP
@onready var _desktop_fps_value : Label = $Desktop/HBox/Value
#== MOBILE
@onready var _mobile_fps_value : Label = $Mobile/HBox/Value


func _physics_process(_delta: float) -> void:
	if visible:
		update_fps(int(Engine.get_frames_per_second()))


func update_fps(value: int) -> void:
	var text = str(value)
	if GameData.isMobile:
		_mobile_fps_value.text = text
	else:
		_desktop_fps_value.text = text
