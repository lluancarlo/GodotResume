extends Control
class_name MenuMain

signal click()
signal resume_pressed()
signal restart_pressed()
signal language_pressed()
signal options_pressed()


@export var linkedin_link : String
@export var github_link : String



func _on_resume_pressed() -> void:
	click.emit()
	resume_pressed.emit()


func _on_restart_pressed() -> void:
	click.emit()
	restart_pressed.emit()


func _on_language_pressed() -> void:
	click.emit()
	language_pressed.emit()


func _on_options_pressed() -> void:
	click.emit()
	options_pressed.emit()


func _on_linked_in_pressed() -> void:
	click.emit()
	if not linkedin_link.is_empty():
		OS.shell_open(linkedin_link)


func _on_github_pressed() -> void:
	click.emit()
	if not github_link.is_empty():
		OS.shell_open(github_link)
