extends Control
class_name UIObjectives

# NODES
@export_category("Default Values")
@export var done_emoji : String = "🟢"
#== DESKTOP
@onready var _desktop : Control = $Desktop
@onready var _desktop_mission1_block : HBoxContainer = $Desktop/Control/Mission1
@onready var _desktop_mission1_value : Label = $Desktop/Control/Mission1/Value
@onready var _desktop_mission2_block : HBoxContainer = $Desktop/Control/Mission2
@onready var _desktop_mission2_value : Label = $Desktop/Control/Mission2/Value
#== MOBILE
@onready var _mobile : Control = $Mobile
@onready var _mobile_mission1_block : HBoxContainer = $Mobile/Control/Mission1
@onready var _mobile_mission1_value : Label = $Mobile/Control/Mission1/Value
@onready var _mobile_mission2_block : HBoxContainer = $Mobile/Control/Mission2
@onready var _mobile_mission2_value : Label = $Mobile/Control/Mission2/Value

#== FUNCTIONS
func _ready() -> void:
	if GameData.is_mobile:
		_desktop.queue_free()
		create_tween().tween_property(_mobile, "modulate:a", 1.0, 1.0).from(0.0)
	else:
		_mobile.queue_free()
		create_tween().tween_property(_desktop, "modulate:a", 1.0, 1.0).from(0.0)

func set_counter_to_mission(mission: int, value: int) -> void:
	_animate_text_mission(mission)
	
	if mission == 1:
		if GameData.is_mobile:
			if value >= 3:
				_mobile_mission1_value.text = done_emoji
			else:
				_mobile_mission1_value.text = str(value) + "/3"
		else:
			if value >= 3:
				_desktop_mission1_value.text = done_emoji
			else:
				_desktop_mission1_value.text = str(value) + "/3"
	elif mission == 2:
		if GameData.is_mobile:
			if value >= 5:
				_mobile_mission2_value.text = done_emoji
			else:
				_mobile_mission2_value.text = str(value) + "/5"
		else:
			if value >= 5:
				_desktop_mission2_value.text = done_emoji
			else:
				_desktop_mission2_value.text = str(value) + "/5"

func _animate_text_mission(mission: int) -> void:
	var block_to_animate: HBoxContainer
	if mission == 1:
		if GameData.is_mobile:
			block_to_animate = _mobile_mission1_block
		else:
			block_to_animate = _desktop_mission1_block
	elif mission == 2:
		if GameData.is_mobile:
			block_to_animate = _mobile_mission2_block
		else:
			block_to_animate = _desktop_mission2_block
	
	var tween = create_tween()
	tween.set_loops(3)
	tween.tween_property(block_to_animate, "scale", Vector2(1.1, 1.1), 0.3)
	tween.tween_property(block_to_animate, "scale", Vector2(0.9, 0.9), 0.3)
	await tween.finished
	
	create_tween().tween_property(block_to_animate, "scale", Vector2.ONE, 0.15)
