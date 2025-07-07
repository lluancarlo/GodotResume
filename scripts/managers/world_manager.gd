extends Node3D
class_name WorldManager


signal Area3d_entered_area(areaName: String)

var is_player_inside_area : bool


func _on_collision_node_3d_entered(collider: Area3D, object: Node3D) -> void:
	if object is PlayerCar and not is_player_inside_area:
		is_player_inside_area = true
		Area3d_entered_area.emit(collider.name)


func _on_collision_node_3d_exited(collider: Area3D, object: Node3D) -> void:
	if object is PlayerCar and is_player_inside_area:
		is_player_inside_area = false
