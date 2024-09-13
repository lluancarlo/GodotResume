extends PanelContainer
class_name MenuMain

signal options_pressed()
signal reset_pressed()

@export var linkedin_link : String
@export var github_link : String
@export var options_menu : MenuOption
@export var _audio_click : AudioStreamPlayer


func _ready() -> void:
	hide()


func _on_menu_pressed() -> void:
	if visible:
		_on_resume_pressed()
	elif not options_menu.visible:
		get_tree().paused = true
		show()


func _on_resume_pressed() -> void:
	_audio_click.play()
	get_tree().paused = false
	hide()


func _on_reset_pressed() -> void:
	_audio_click.play()
	reset_pressed.emit()


func _on_options_pressed() -> void:
	_audio_click.play()
	options_pressed.emit()


func _on_linked_in_pressed() -> void:
	_audio_click.play()
	if not linkedin_link.is_empty():
		OS.shell_open(linkedin_link)


func _on_git_hub_pressed() -> void:
	_audio_click.play()
	if not github_link.is_empty():
		OS.shell_open(github_link)
