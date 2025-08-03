extends CanvasLayer
class_name UiManager

#== SIGNALS
signal initial_menus_closed()
signal ui_reset_player()

#== NODES
@onready var _initial_language : MenuLanguage = $Language
@onready var _blackscreen : ColorRect = $Blackscreen
@onready var _mobile_inputs : MobileInputs = $MobileInputs
#==== HUD
@onready var _hud_debug : UIDebug = $HUD/UIDebug
@onready var _hud_text_overlay : UITextOverlay = $HUD/UITextOverlay
@onready var _hud_car_infos : UICarInfos = $HUD/UICarInfos
#==== MENUS
@onready var _menus : Control = $Menus
@onready var _menu_main : MenuMain = $Menus/Main
@onready var _menu_options : MenuOption = $Menus/Options
@onready var _menu_language : MenuLanguage = $Menus/Language
#==== POUPS
@onready var _popups : Control = $Popups
@onready var _dialog_born : BaseDialog = $Popups/Born
@onready var _dialog_live : BaseDialog = $Popups/Live
@onready var _dialog_university : BaseDialog = $Popups/University
@onready var _dialog_consinco : BaseDialog = $Popups/Consinco
@onready var _dialog_magit : BaseDialog= $Popups/Magit
@onready var _dialog_topgaming : BaseDialog = $Popups/TopGaming
@onready var _dialog_deltaengine : BaseDialog = $Popups/DeltaEngine
@onready var _dialog_amilon : BaseDialog = $Popups/Amilon
#==== SOUNDS
@onready var _audio_open : AudioStreamPlayer = $AudioOpen
@onready var _audio_close : AudioStreamPlayer = $AudioClose
@onready var _audio_click : AudioStreamPlayer = $AudioClick

#== VARIABLES
var current_dialog : BaseDialog
var current_dialog_index : GameData.PickUps
var current_ui : Control
var enable_pause_menu : bool

#== FUNCTIONS
func _ready():
	if GameData.is_mobile:
		_mobile_inputs.show()
	else:
		_mobile_inputs.hide()

	_hud_car_infos.hide()
	_hud_debug.hide()
	_hud_text_overlay.hide()
	for menu in _menus.get_children():
		menu.hide()
	for popup in _popups.get_children():
		popup.hide()
	
	self.set_physics_process(false)

func _physics_process(_delta: float) -> void:
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
	
	if Input.is_action_just_pressed("interactive"):
		if current_dialog_index != 0:
			if current_dialog != null:
				close_current_ui()
			else:
				var popup = get_popup_by_id(current_dialog_index)
				if popup == null:
					return
				current_dialog = popup
				current_dialog.open()

				GameData.can_drive = false

func open_ui(ui: Control, play_sound: bool = true) -> void:
	if play_sound:
		_audio_open.play()

	current_ui = ui
	current_ui.show()

	GameData.can_drive = false

func effect_transition_in(duration: float) -> void:
	create_tween().tween_property(_blackscreen, "modulate:a", 0.0, duration).from(1.0)

func set_game_mode() -> void:
	_hud_car_infos.show()

func show_overlay_area(areaName: String) -> void:
	_hud_text_overlay.show()
	await _hud_text_overlay.show_text(tr(areaName))
	_hud_text_overlay.hide()

func update_gear(gear: int) -> void:
	_hud_car_infos.update_gear(gear)

func update_speed(speed: int) -> void:
	_hud_car_infos.update_speed(speed)

func get_popup_by_id(id: GameData.PickUps) -> BaseDialog:
	match(id):
		GameData.PickUps.Born:
			return _dialog_born
		GameData.PickUps.Live:
			return _dialog_live
		GameData.PickUps.University:
			return _dialog_university
		GameData.PickUps.Consinco:
			return _dialog_consinco
		GameData.PickUps.Magit:
			return _dialog_magit
		GameData.PickUps.TopGaming:
			return _dialog_topgaming
		GameData.PickUps.DeltaEngine:
			return _dialog_deltaengine
		GameData.PickUps.Amilon:
			return _dialog_amilon
		_:
			return null

func enable_open_dialog_mode(dialog_index: GameData.PickUps) -> void:
	current_dialog_index = dialog_index
	_mobile_inputs.toggle_interact_button(dialog_index != GameData.PickUps.None)

#== SIGNAL FUNCTIONS
func _on_ui_click() -> void:
	_audio_click.play()

func close_current_ui(play_sound: bool = true) -> void:
	if play_sound:
		_audio_close.play()

	if current_ui:
		current_ui.hide()
		current_ui = null
	
	if current_dialog:
		current_dialog.close()
		current_dialog = null

	GameData.can_drive = true

func _on_initial_language_close() -> void:
	self.set_physics_process(true)
	initial_menus_closed.emit()
	_initial_language.hide()

#==== MAIN
func _on_menu_main_resume_pressed() -> void:
	close_current_ui(false)
	get_tree().paused = false

func _on_menu_main_restart_pressed() -> void:
	ui_reset_player.emit()
	close_current_ui(false)
	get_tree().paused = false

func _on_menu_main_options_pressed() -> void:
	close_current_ui(false)
	open_ui(_menu_options)

#==== OPTIONS
func _on_menu_options_close_pressed() -> void:
	close_current_ui(false)
	open_ui(_menu_main)

func _on_menu_options_show_fps(show_fps: bool) -> void:
	if show_fps:
		_hud_debug.show()
	else:
		_hud_debug.hide()

#==== LANGUAGE
func _on_menu_language_close_pressed() -> void:
	close_current_ui(false)
	open_ui(_menu_main)

func _on_menu_main_language_pressed() -> void:
	close_current_ui(false)
	open_ui(_menu_language)
