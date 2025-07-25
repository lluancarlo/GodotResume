extends Node
class_name Loading


@onready var _menu_language : Control = $SelectLanguage

#var main_scene : PackedScene = preload("res://scenes/game.tscn")


func transition_to_game() -> void:
	await create_tween().tween_property(_menu_language, "modulate:a", 0.0, 0.5).from(1.0).finished
	_menu_language.hide()
	
	#get_tree().change_scene_to_packed(main_scene)


func _on_english_pressed() -> void:
	TranslationServer.set_locale("en-US")
	transition_to_game()


func _on_italian_pressed() -> void:
	TranslationServer.set_locale("it-IT")
	transition_to_game()


func _on_portuguese_pressed() -> void:
	TranslationServer.set_locale("pt-BR")
	transition_to_game()


func _on_spanish_pressed() -> void:
	TranslationServer.set_locale("es-ES")
	transition_to_game()
