extends Node
#class_name GameData


signal popup_id_changed()


enum Popups
{
	Warning,
	Born,
	Live,
	University,
	Consinco,
	Magit,
	TopGaming,
	DeltaEngine,
	Amilon
}


var on_popup_id : int
var is_mobile : bool


func _ready() -> void:
	is_mobile = OS.has_feature("web_android") or OS.has_feature("web_ios")


func set_popup_id(id: int) -> void:
	on_popup_id = id
	popup_id_changed.emit()
