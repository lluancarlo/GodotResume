extends Node
class_name Loading


@onready var _menu_language : Control = $SelectLanguage

var main_scene_path := "res://scenes/game.tscn"
var main_scene_resource : PackedScene
var load_in_progress := false


func _ready():
	# Start loading the heavy scene in background
	ResourceLoader.load_threaded_request(main_scene_path)
	load_in_progress = true
	print("Loading MainGame.tscn in background...")


func _process(_delta):
	if load_in_progress:
		var status = ResourceLoader.load_threaded_get_status(main_scene_path)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			main_scene_resource = ResourceLoader.load_threaded_get(main_scene_path)
			print("MainGame.tscn loaded and ready!")
			load_in_progress = false
			# You can now switch scenes when the player is ready
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Failed to load main scene.")
			load_in_progress = false


func transition_to_game() -> void:
	while load_in_progress:
		pass
	
	await create_tween().tween_property(_menu_language, "modulate:a", 0.0, 0.5).from(1.0).finished
	_menu_language.hide()
	
	get_tree().change_scene_to_packed(main_scene_resource)


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
