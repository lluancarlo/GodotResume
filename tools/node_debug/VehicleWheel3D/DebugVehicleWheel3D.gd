extends TabContainer
class_name DebugVehicleWheel3D

# Exports
@export var show_per_wheel_motion := true
@export var show_wheel := true
@export var show_suspension := true
@export var show_damping := true
@export var front_wheel_left : NodePath
@export var front_wheel_right : NodePath
@export var rear_wheel_left : NodePath
@export var rear_wheel_right : NodePath
@onready var _front_ref_wheel_l = get_node(front_wheel_left) as VehicleWheel3D
@onready var _front_ref_wheel_r = get_node(front_wheel_right) as VehicleWheel3D
@onready var _rear_ref_wheel_l = get_node(rear_wheel_left) as VehicleWheel3D
@onready var _rear_ref_wheel_r = get_node(rear_wheel_right) as VehicleWheel3D
@onready var _tab_front := $Front as DebugVehicleWheel3DTab
@onready var _tab_rear := $Rear as DebugVehicleWheel3DTab


func _ready() -> void:
	check_nodes()
	hide_panels()
	update_all_tabs()


func check_nodes() -> void:
	assert(_front_ref_wheel_l != null, "Add a ref to VehicleWheel3D FRONT-LEFT you want to track")
	assert(_front_ref_wheel_r != null, "Add a ref to VehicleWheel3D FRONT-RIGHT you want to track")
	assert(_rear_ref_wheel_l != null, "Add a ref to VehicleWheel3D REAR-LEFT you want to track")
	assert(_rear_ref_wheel_r != null, "Add a ref to VehicleWheel3D REAR-RIGHT you want to track")


func hide_panels() -> void:
	if (!show_per_wheel_motion):
		_tab_front.pw_motion.hide()
		_tab_rear.pw_motion.hide()
	if (!show_wheel):
		_tab_front.wheel.hide()
		_tab_rear.wheel.hide()
	if (!show_suspension):
		_tab_front.suspension.hide()
		_tab_rear.suspension.hide()
	if (!show_damping):
		_tab_front.damping.hide()
		_tab_rear.damping.hide()


func update_all_tabs() -> void:
	_tab_front.set_wheel(_front_ref_wheel_l.wheel_roll_influence, _front_ref_wheel_l.wheel_radius, _front_ref_wheel_l.wheel_rest_length, _front_ref_wheel_l.wheel_friction_slip)
	_tab_front.set_suspension(_front_ref_wheel_l.suspension_travel, _front_ref_wheel_l.suspension_stiffness, _front_ref_wheel_l.suspension_max_force)
	_tab_front.set_damping(_front_ref_wheel_l.damping_compression, _front_ref_wheel_l.damping_relaxation)
	_tab_rear.set_wheel(_rear_ref_wheel_l.wheel_roll_influence, _rear_ref_wheel_l.wheel_radius, _rear_ref_wheel_l.wheel_rest_length, _rear_ref_wheel_l.wheel_friction_slip)
	_tab_rear.set_suspension(_rear_ref_wheel_l.suspension_travel, _rear_ref_wheel_l.suspension_stiffness, _rear_ref_wheel_l.suspension_max_force)
	_tab_rear.set_damping(_rear_ref_wheel_l.damping_compression, _rear_ref_wheel_l.damping_relaxation)


func format_float_str(value: float) -> String:
	return str(snapped(value, 0.01))


func _process(_d: float) -> void:
	if show_per_wheel_motion:
		if _tab_front.visible:
			_tab_front.pw_motion_engine_force.text = format_float_str(_front_ref_wheel_l.engine_force)
			_tab_front.pw_motion_brake.text = format_float_str(_front_ref_wheel_l.brake)
			_tab_front.pw_motion_steering.text = format_float_str(_front_ref_wheel_l.steering)
		else:
			_tab_rear.pw_motion_engine_force.text = format_float_str(_rear_ref_wheel_l.engine_force)
			_tab_rear.pw_motion_brake.text = format_float_str(_rear_ref_wheel_l.brake)
			_tab_rear.pw_motion_steering.text = format_float_str(_rear_ref_wheel_l.steering)
	if show_wheel:
		if _tab_front.visible:
			_tab_front.wheel_rollinfluence.text = format_float_str(_front_ref_wheel_l.wheel_roll_influence)
			_tab_front.wheel_radius.text = format_float_str(_front_ref_wheel_l.wheel_radius)
			_tab_front.wheel_restlength.text = format_float_str(_front_ref_wheel_l.wheel_rest_length)
			_tab_front.wheel_frictionslip.text = format_float_str(_front_ref_wheel_l.wheel_friction_slip)
		else:
			_tab_rear.wheel_rollinfluence.text = format_float_str(_rear_ref_wheel_l.wheel_roll_influence)
			_tab_rear.wheel_radius.text = format_float_str(_rear_ref_wheel_l.wheel_radius)
			_tab_rear.wheel_restlength.text = format_float_str(_rear_ref_wheel_l.wheel_rest_length)
			_tab_rear.wheel_frictionslip.text = format_float_str(_rear_ref_wheel_l.wheel_friction_slip)
	if show_suspension:
		if _tab_front.visible:
			_tab_front.suspension_travel.text = format_float_str(_front_ref_wheel_l.suspension_travel)
			_tab_front.suspension_stiffness.text = format_float_str(_front_ref_wheel_l.suspension_stiffness)
			_tab_front.suspension_maxforce.text = format_float_str(_front_ref_wheel_l.suspension_max_force)
		else:
			_tab_rear.suspension_travel.text = format_float_str(_rear_ref_wheel_l.suspension_travel)
			_tab_rear.suspension_stiffness.text = format_float_str(_rear_ref_wheel_l.suspension_stiffness)
			_tab_rear.suspension_maxforce.text = format_float_str(_rear_ref_wheel_l.suspension_max_force)
	if show_damping:
		if _tab_front.visible:
			_tab_front.damping_compression.text = format_float_str(_front_ref_wheel_l.damping_compression)
			_tab_front.damping_relaxation.text = format_float_str(_front_ref_wheel_l.damping_relaxation)
		else:
			_tab_rear.damping_compression.text = format_float_str(_rear_ref_wheel_l.damping_compression)
			_tab_rear.damping_relaxation.text = format_float_str(_rear_ref_wheel_l.damping_relaxation)


func _on_front_wheel_rollinfluence_changed(value: float) -> void:
	_front_ref_wheel_l.wheel_roll_influence = value
	_front_ref_wheel_r.wheel_roll_influence = value


func _on_front_wheel_radius_changed(value: float) -> void:
	_front_ref_wheel_l.wheel_radius = value
	_front_ref_wheel_r.wheel_radius = value


func _on_front_wheel_restlength_changed(value: float) -> void:
	_front_ref_wheel_l.wheel_rest_length = value
	_front_ref_wheel_r.wheel_rest_length = value


func _on_front_wheel_frictionslip_changed(value: float) -> void:
	_front_ref_wheel_l.wheel_friction_slip = value
	_front_ref_wheel_r.wheel_friction_slip = value


func _on_front_suspension_travel_changed(value: float) -> void:
	_front_ref_wheel_l.suspension_travel = value
	_front_ref_wheel_r.suspension_travel = value


func _on_front_suspension_stiffness_changed(value: float) -> void:
	_front_ref_wheel_l.suspension_stiffness = value
	_front_ref_wheel_r.suspension_stiffness = value


func _on_front_suspension_maxforce_changed(value: float) -> void:
	_front_ref_wheel_l.suspension_max_force = value
	_front_ref_wheel_r.suspension_max_force = value


func _on_front_damping_compression_changed(value: float) -> void:
	_front_ref_wheel_l.damping_compression = value
	_front_ref_wheel_r.damping_compression = value


func _on_front_damping_relaxation_changed(value: float) -> void:
	_front_ref_wheel_l.damping_relaxation = value
	_front_ref_wheel_r.damping_relaxation = value


func _on_rear_wheel_rollinfluence_changed(value: float) -> void:
	_rear_ref_wheel_l.wheel_roll_influence = value
	_rear_ref_wheel_r.wheel_roll_influence = value


func _on_rear_wheel_radius_changed(value: float) -> void:
	_rear_ref_wheel_l.wheel_radius = value
	_rear_ref_wheel_r.wheel_radius = value


func _on_rear_wheel_restlength_changed(value: float) -> void:
	_rear_ref_wheel_l.wheel_rest_length = value
	_rear_ref_wheel_r.wheel_rest_length = value


func _on_rear_wheel_frictionslip_changed(value: float) -> void:
	_rear_ref_wheel_l.wheel_friction_slip = value
	_rear_ref_wheel_r.wheel_friction_slip = value


func _on_rear_suspension_travel_changed(value: float) -> void:
	_rear_ref_wheel_l.suspension_travel = value
	_rear_ref_wheel_r.suspension_travel = value


func _on_rear_suspension_stiffness_changed(value: float) -> void:
	_rear_ref_wheel_l.suspension_stiffness = value
	_rear_ref_wheel_r.suspension_stiffness = value


func _on_rear_suspension_maxforce_changed(value: float) -> void:
	_rear_ref_wheel_l.suspension_max_force = value
	_rear_ref_wheel_r.suspension_max_force = value


func _on_rear_damping_compression_changed(value: float) -> void:
	_rear_ref_wheel_l.damping_compression = value
	_rear_ref_wheel_r.damping_compression = value


func _on_rear_damping_relaxation_changed(value: float) -> void:
	_rear_ref_wheel_l.damping_relaxation = value
	_rear_ref_wheel_r.damping_relaxation = value
