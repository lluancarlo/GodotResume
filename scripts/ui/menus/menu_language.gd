extends Control
class_name MenuLanguage

#== SIGNALS
signal click()
signal close_pressed()

#== NODES
@onready var _back_button : TextureButton = $Dialog/Head/Back

#== EXPORTS
@export var show_back_button : bool = true

#== FUNCTIONS
func _ready() -> void:
	if show_back_button:
		_back_button.show()
	else:
		_back_button.hide()

# SIGNAL FUNCTIONS
func _on_close_pressed() -> void:
	click.emit()
	close_pressed.emit()

func _on_english_pressed() -> void:
	click.emit()
	TranslationServer.set_locale("en-US")
	close_pressed.emit()

func _on_italian_pressed() -> void:
	click.emit()
	TranslationServer.set_locale("it-IT")
	close_pressed.emit()

func _on_portuguese_pressed() -> void:
	click.emit()
	TranslationServer.set_locale("pt-BR")
	close_pressed.emit()

func _on_spanish_pressed() -> void:
	click.emit()
	TranslationServer.set_locale("es-ES")
	close_pressed.emit()
