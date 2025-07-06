extends Control
class_name BaseDialog

signal closed()

@export var link : String

var anim_duration : float = 0.2

func open() -> void:
	self.show()
	await create_tween().tween_property(self, "modulate:a", 1.0, anim_duration).from(0.0).finished


func close() -> void:
	await create_tween().tween_property(self, "modulate:a",0.0, anim_duration).from(1.0).finished
	self.hide()


func open_link() -> void:
	if not link.is_empty():
		OS.shell_open(link)


func _on_close_pressed() -> void:
	closed.emit()
