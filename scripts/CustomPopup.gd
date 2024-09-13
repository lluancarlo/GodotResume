extends BasePopup
class_name CustomPopup

signal closed()

@export var logo_link : String
@onready var _anim := $AnimationPlayer as AnimationPlayer
@onready var _close_button := $VBox/Header/Close as TextureButton

func open() -> void:
	visible = true
	_close_button.disabled = false
	_anim.play("open")

func close() -> void:
	_close_button.disabled = true
	_anim.animation_finished.connect(_on_animation_finished)
	_anim.play("close")

func _on_close_pressed():
	close()

func _on_animation_finished(_anim_name: String) -> void:
	visible = false
	_anim.animation_finished.disconnect(_on_animation_finished)
	closed.emit()


func _on_logo_pressed() -> void:
	if not logo_link.is_empty():
		OS.shell_open(logo_link)
