extends Control
class_name UICarInfos


# NODES
#== DESKTOP
@onready var _desktop : Control = $Desktop
@onready var _desktop_gear : Label = $Desktop/VBox/Gear/Value
@onready var _desktop_speed : Label = $Desktop/VBox/Speed/Value
#== MOBILE
@onready var _mobile : Control = $Mobile
@onready var _mobile_gear : Label = $Mobile/VBox/Gear/Value
@onready var _mobile_speed : Label = $Mobile/VBox/Speed/Value


func _ready() -> void:
	if GameData.is_mobile:
		_desktop.queue_free()
	else:
		_mobile.queue_free()


func update_gear(value: int) -> void:
	var text = str(value) if value > 0 else 'R'
	if GameData.is_mobile:
		_mobile_gear.text = text
	else:
		_desktop_gear.text = text


func update_speed(value: int) -> void:
	var text = str(value)
	if GameData.is_mobile:
		_mobile_speed.text = text
	else:
		_desktop_speed.text = text
