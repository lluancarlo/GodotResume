extends Node

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

func set_popup_id(id: int) -> void:
	on_popup_id = id
	popup_id_changed.emit()
