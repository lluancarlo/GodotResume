extends Control
class_name SmartControl

# Nodes
@onready var _desktop: Control = get_node_or_null('Desktop')
@onready var _mobile : Control = get_node_or_null('Mobile')

# Variables
var isMobile: bool


func _ready() -> void:
	assert(_desktop != null, "Cannot find _desktop node on the extended class !")
	assert(_mobile != null, "Cannot find _mobile node on the extended class !")

	isMobile = OS.has_feature("web_android") or OS.has_feature("web_ios")
	if isMobile:
		_mobile.visible = true
		_desktop.queue_free()
	else:
		_desktop.visible = true
		_mobile.queue_free()


func get_is_mobile() -> bool:
	return isMobile
