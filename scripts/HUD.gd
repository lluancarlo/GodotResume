extends Control
class_name HUD


@export_category(&"Node paths")
@export var _fps_group : HBoxContainer
@export var _fps : Label
@export var _gear : Label
@export var _speed : Label
@export var _overlay_group : Control
@export var _overlay : Label
var is_showing : bool
var fade_duration := 0.5


func _ready() -> void:
	_overlay_group.modulate.a = 0
	_fps_group.hide()


func _process(_delta):
	if _fps_group.visible:
		_fps.text = str(Engine.get_frames_per_second())


func show_overlay_area(area_name: String, duration: float = 2.0) -> void:
	_overlay.text = area_name
	await create_tween().tween_property(_overlay_group, "modulate:a", 1.0, fade_duration).from(0.0).finished
	await get_tree().create_timer(duration).timeout
	await create_tween().tween_property(_overlay_group, "modulate:a", 0.0, fade_duration).from(1.0).finished


func update_gear(gear: int) -> void:
	_gear.text = str(gear if gear > 0 else 'R')


func update_speed(speed: int) -> void:
	_speed.text = str(speed)


func _on_options_show_fps(show: bool) -> void:
	_fps_group.visible = show
