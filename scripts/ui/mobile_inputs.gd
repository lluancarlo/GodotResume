extends SmartControl
class_name MobileInputs


func _ready() -> void:
	if not super.get_is_mobile():
		self.queue_free()


func _on_left_button_down() -> void:
	PlayerInput.axisX += 1


func _on_left_button_up() -> void:
	PlayerInput.axisX -= 1


func _on_right_button_down() -> void:
	PlayerInput.axisX -= 1


func _on_right_button_up() -> void:
	PlayerInput.axisX += 1


func _on_gas_button_down() -> void:
	PlayerInput.axisY += 1


func _on_gas_button_up() -> void:
	PlayerInput.axisY -= 1


func _on_break_button_down() -> void:
	PlayerInput.axisY -= 1


func _on_break_button_up() -> void:
	PlayerInput.axisY += 1
