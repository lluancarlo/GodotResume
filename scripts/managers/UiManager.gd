extends Control
class_name UiManager


# NODES
#== HUD
@onready var _hud_debug : UIDebug = $HUD/UIDebug
@onready var _hud_text_overlay : UITextOverlay = $HUD/UITextOverlay
@onready var _hud_car_infos : UICarInfos = $HUD/UICarInfos
#== Menus
@onready var _menus : Control = $Menus
@onready var _menu_main : MenuMain = $Menus/Main
@onready var _menu_options : MenuOption = $Menus/Options
#== Popups
@onready var _popups : Control = $Popups
@onready var _dialog_born : BaseDialog = $Popups/Born
@onready var _dialog_live : BaseDialog = $Popups/Live
@onready var _dialog_university : BaseDialog = $Popups/University
@onready var _dialog_consinco : BaseDialog = $Popups/Consinco
@onready var _dialog_magit : BaseDialog= $Popups/Magit
@onready var _dialog_topgaming : BaseDialog = $Popups/TopGaming
@onready var _dialog_deltaengine : BaseDialog = $Popups/DeltaEngine
@onready var _dialog_amilon : BaseDialog = $Popups/Amilon
#== Sounds
@onready var _audio_open : AudioStreamPlayer = $AudioOpen
@onready var _audio_close : AudioStreamPlayer = $AudioClose
@onready var _audio_click : AudioStreamPlayer = $AudioClick

# Export
@export var _player : PlayerCar

# Variables
var current_dialog : BaseDialog
var current_ui : Control


func _ready():
	PlayerInput.interactive_pressed.connect(_on_interactive_pressed)

	_hud_debug.hide()
	_hud_text_overlay.hide()
	_hud_car_infos.show()

	for menu in _menus.get_children():
		menu.hide()

	for popup in _popups.get_children():
		popup.hide()


func _physics_process(_d: float) -> void:
	if Input.is_action_just_pressed("menu"):
		if current_dialog != null:
			close_current_ui()
			get_tree().paused = false
		elif current_ui != null:
			close_current_ui()
			get_tree().paused = false
		elif current_ui == null:
			open_ui(_menu_main)
			get_tree().paused = true



func _on_interactive_pressed() -> void:
	if GameData.on_popup_id != 0:
		if current_dialog != null:
			close_current_ui()
		else:
			open_dialog(get_popup_by_id(GameData.on_popup_id))
		


# General
func _on_ui_click() -> void:
	_audio_click.play()


func open_ui(ui: Control, play_sound: bool = true) -> void:
	if play_sound:
		_audio_open.play()

	current_ui = ui
	current_ui.show()

	_player.can_drive = false


func open_dialog(dialog: BaseDialog, play_sound: bool = true) -> void:
	if play_sound:
		_audio_open.play()

	current_dialog = dialog
	current_dialog.open()

	_player.can_drive = false


func close_current_ui(play_sound: bool = true) -> void:
	if play_sound:
		_audio_close.play()

	if current_ui:
		current_ui.hide()
		current_ui = null
	
	if current_dialog:
		current_dialog.close()
		current_dialog = null

	_player.can_drive = true


# HUD
#== TextOverlay
func show_area_overlay(area_name: String) -> void:
	_hud_text_overlay.show_text(area_name)


#== CarInfos
func update_gear(gear: int) -> void:
	_hud_car_infos.update_gear(gear)


func update_speed(speed: int) -> void:
	_hud_car_infos.update_speed(speed)


# Menus
#== Main
func _on_menu_main_resume_pressed() -> void:
	close_current_ui(false)
	get_tree().paused = false


func _on_menu_main_restart_pressed() -> void:
	_player.reset_position()
	close_current_ui(false)
	get_tree().paused = false


func _on_menu_main_options_pressed() -> void:
	close_current_ui(false)
	open_ui(_menu_options)


#== Options
func _on_menu_options_close_pressed() -> void:
	close_current_ui(false)
	open_ui(_menu_main)


func _on_menu_options_show_fps(show_fps: bool) -> void:
	if show_fps:
		_hud_debug.show()
	else:
		_hud_debug.hide()


# Popups
func get_popup_by_id(id: int) -> BaseDialog:
	match(id):
		GameData.Popups.Born:
			return _dialog_born
		GameData.Popups.Live:
			return _dialog_live
		GameData.Popups.University:
			return _dialog_university
		GameData.Popups.Consinco:
			return _dialog_consinco
		GameData.Popups.Magit:
			return _dialog_magit
		GameData.Popups.TopGaming:
			return _dialog_topgaming
		GameData.Popups.DeltaEngine:
			return _dialog_deltaengine
		GameData.Popups.Amilon:
			return _dialog_amilon
		_:
			return null
