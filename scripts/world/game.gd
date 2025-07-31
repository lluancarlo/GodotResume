extends Node3D
class_name Game

#== NODES
@onready var _world_manager : WorldManager = $WorldManager
@onready var _ui_manager : UiManager = $UiManager

#== EXPORT
@export var initial_menu_effect_duration : float = 1.0

#== SIGNAL FUNCTIONS
func _on_world_manager_area_3d_entered_area(area_name: String) -> void:
	_ui_manager.show_overlay_area(area_name)

func _on_initial_menus_closed() -> void:
	_ui_manager.effect_transition_in(initial_menu_effect_duration)
	_ui_manager.set_game_mode()
	_world_manager.effect_transition_in(initial_menu_effect_duration)
	GameData.can_drive = true

func _on_ui_manager_ui_reset_player() -> void:
	_world_manager.reset_player_position()

func _on_world_manager_player_on_pickup(pickup_id: GameData.PickUps) -> void:
	_ui_manager.current_dialog_index = pickup_id

func _on_world_manager_player_gear_change(gear: int) -> void:
	_ui_manager.update_gear(gear)

func _on_world_manager_player_speed_change(speed: int) -> void:
	_ui_manager.update_speed(speed)
