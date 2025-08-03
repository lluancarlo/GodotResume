extends Control
class_name MobileInputs

#== NODES
@onready var _button_left : TouchScreenButton = $Directions/Left/Button
@onready var _button_right : TouchScreenButton = $Directions/Right/Right
@onready var _button_gas : TouchScreenButton = $Buttons/Gas/Button
@onready var _button_back : TouchScreenButton = $Buttons/Back/Button
@onready var _button_menu : TouchScreenButton = $Menu/Button
@onready var _button_interact : TouchScreenButton = $Interact/Button

#== FUNCTIONS
func _ready() -> void:
	await get_tree().process_frame
	if GameData.is_mobile:
		_button_interact.visible = false

func toggle_interact_button(enable: bool) -> void:
	_button_interact.visible = enable

#== SIGNAL FUNCTIONS
func _on_button_visual_change(button: TouchScreenButton, press: bool) -> void:
	button.modulate.a = 0.5 if press else 1.0

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

func _on_mobile_axis_joystick_moved(direction: Vector2) -> void:
	if direction.x == 0:
		Input.action_press("right", 0.0)
		Input.action_press("left", 0.0)
	elif direction.x > 0:
		Input.action_press("right", direction.x)
		Input.action_press("left", 0.0)
	else:
		Input.action_press("right", 0.0)
		Input.action_press("left", -direction.x)
