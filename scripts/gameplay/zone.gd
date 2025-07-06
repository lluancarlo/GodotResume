extends Node3D
class_name Zone

@export var _ui_manager : UiManager
var is_player_inside : bool


func _on_area_3d_body_shape_entered(_br: RID, body: Node3D, _bsi: int, _lsi: int) -> void:
	if body is PlayerCar and not is_player_inside:
		is_player_inside = true
		_ui_manager.show_area_overlay(name)


func _on_area_3d_body_shape_exited(_br: RID, body: Node3D, _bsi: int, _lsi: int) -> void:
	if body is PlayerCar and is_player_inside:
		is_player_inside = false
