extends SmartControl
class_name MobileInputs


@onready var _button_left : TouchScreenButton = $Mobile/Left
@onready var _button_right : TouchScreenButton = $Mobile/Right
@onready var _button_gas : TouchScreenButton = $Mobile/Gas
@onready var _button_back : TouchScreenButton = $Mobile/Back
@onready var _button_menu : TouchScreenButton = $Mobile/Menu
@onready var _button_interact : TouchScreenButton = $Mobile/Interact


func _on_button_visual_change(button: TouchScreenButton, press: bool) -> void:
	button.modulate.a = 0.5 if press else 1.0


func _ready() -> void:
	await get_tree().process_frame
	super._ready()
	_button_interact.visible = false
	GameData.popup_id_changed.connect(_on_popup_changed)


func _on_popup_changed() -> void:
	_button_interact.visible = GameData.on_popup_id != 0


func _on_left_pressed() -> void:
	_on_button_visual_change(_button_left, true)

func _on_left_released() -> void:
	_on_button_visual_change(_button_left, false)


func _on_right_pressed() -> void:
	_on_button_visual_change(_button_right, true)

func _on_right_released() -> void:
	_on_button_visual_change(_button_right, false)


func _on_gas_pressed() -> void:
	_on_button_visual_change(_button_gas, true)

func _on_gas_released() -> void:
	_on_button_visual_change(_button_gas, false)


func _on_back_pressed() -> void:
	_on_button_visual_change(_button_back, true)

func _on_back_released() -> void:
	_on_button_visual_change(_button_back, false)


func _on_menu_pressed() -> void:
	_on_button_visual_change(_button_menu, true)

func _on_menu_released() -> void:
	_on_button_visual_change(_button_menu, false)


func _on_interact_pressed() -> void:
	_on_button_visual_change(_button_interact, true)

func _on_interact_released() -> void:
	_on_button_visual_change(_button_interact, false)
