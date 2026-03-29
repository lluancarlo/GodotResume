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
	_ui_manager.enable_open_dialog_mode(pickup_id)

func _on_world_manager_player_gear_change(gear: int) -> void:
	_ui_manager.update_gear(gear)

func _on_world_manager_player_speed_change(speed: int) -> void:
	_ui_manager.update_speed(speed)

func _on_ui_manager_popup_closed(index: GameData.PickUps) -> void:
	if index not in GameData.pickups_done:
		GameData.pickups_done.append(index)
		if index in [GameData.PickUps.Born, GameData.PickUps.Live, GameData.PickUps.University]:
			GameData.mission_1_count += 1
			_ui_manager.add_objective_count(1, GameData.mission_1_count)
		elif index in [GameData.PickUps.Consinco, GameData.PickUps.Magit, GameData.PickUps.TopGaming,\
			GameData.PickUps.DeltaEngine, GameData.PickUps.Amilon]:
			GameData.mission_2_count += 1
			_ui_manager.add_objective_count(2, GameData.mission_2_count)
