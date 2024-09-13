extends PanelContainer
class_name MenuOption


signal show_fps(show: bool)
signal close_pressed()
enum Config { LOW, MEDIUM, HIGH }
@export_category(&"Audio")
@export var _audio_switch : AudioStreamPlayer
@export var _audio_click : AudioStreamPlayer
@export_category(&"Game Configs")
@export_subgroup(&"Low")
@export var low_vibilitity_range = 25
@export var low_shadow_distance = 15
@export_subgroup(&"Medium")
@export var medium_vibilitity_range = 35
@export var medium_shadow_distance = 25
@export_subgroup(&"High")
@export var high_vibilitity_range = 0
@export var high_shadow_distance = 60
@export_category(&"Node Paths")
@export var menu_options_graphics_low_btn : Button
@export var menu_options_graphics_medium_btn : Button
@export var menu_options_graphics_high_btn : Button

var current_config := Config.MEDIUM


func _ready() -> void:
	hide()


func _on_menu_pressed() -> void:
	if visible:
		_on_close_pressed()


func on_graphics_selected(selected: bool, config: Config) -> void:
	_audio_switch.play()
	if (not menu_options_graphics_low_btn.button_pressed and 
		not menu_options_graphics_medium_btn.button_pressed and
		not menu_options_graphics_high_btn.button_pressed):
		if config == Config.LOW:
			menu_options_graphics_low_btn.set_pressed_no_signal(true)
		elif config == Config.MEDIUM:
			menu_options_graphics_medium_btn.set_pressed_no_signal(true)
		else:
			menu_options_graphics_high_btn.set_pressed_no_signal(true)
		return
	
	if config == Config.LOW:
		menu_options_graphics_medium_btn.set_pressed_no_signal(false)
		menu_options_graphics_high_btn.set_pressed_no_signal(false)
	elif config == Config.MEDIUM:
		menu_options_graphics_low_btn.set_pressed_no_signal(false)
		menu_options_graphics_high_btn.set_pressed_no_signal(false)
	else:
		menu_options_graphics_low_btn.set_pressed_no_signal(false)
		menu_options_graphics_medium_btn.set_pressed_no_signal(false)
	
	set_all_configs(config)


func set_all_configs(config: Config) -> void:
	current_config = config
	call_in_all_children(get_tree().current_scene, set_config)
	var sun = find_node(get_tree().current_scene, DirectionalLight3D) as DirectionalLight3D
	assert(sun != null, "cannot find the DirectionalLight3D")
	sun.directional_shadow_max_distance = get_shadow_distance(config)


func set_audios(volume: float) -> void:
	AudioServer.set_bus_volume_db(0, lerp(-30, 10, volume / 100))


func set_config(node: Node) -> void:
	if (node is MeshInstance3D) and (not node.is_in_group(&"ground")):
		node.visibility_range_end = get_visibility_range(current_config)


func find_node(parent_node: Node, type, deep_look: bool = true):
	var found_node = null
	for node: Node in parent_node.get_children():
		if deep_look and (node.get_child_count() > 0):
			found_node = find_node(node, type)
		if is_instance_of(node, type):
			found_node = node
		if found_node != null:
			break
	return found_node


func call_in_all_children(main_node: Node, execute: Callable) -> void:
	for node: Node in main_node.get_children():
		if (node.get_child_count() > 0):
			call_in_all_children(node, execute)
		if (node is MeshInstance3D):
			execute.call(node)


func get_visibility_range(config: Config) -> int:
	match(config):
		Config.LOW:
			return low_vibilitity_range
		Config.MEDIUM:
			return medium_vibilitity_range
		_:
			return high_vibilitity_range


func get_shadow_distance(config: Config) -> int:
	match(config):
		Config.LOW:
			return low_shadow_distance
		Config.MEDIUM:
			return medium_shadow_distance
		_:
			return high_shadow_distance


func _on_fps_toggle_pressed(toggled_on: bool) -> void:
	_audio_switch.play()
	show_fps.emit(toggled_on)


func _on_close_pressed() -> void:
	_audio_click.play()
	close_pressed.emit()
