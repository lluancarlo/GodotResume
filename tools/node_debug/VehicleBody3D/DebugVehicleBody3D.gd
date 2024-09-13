extends Panel
class_name DebugVehicleBody3D

# Exports
@export var node_vehiclebody3D : NodePath
@export var show_node_name := false
@export var show_motion := true
@export var show_rigidbody3d := true

@onready var _ref_vehiclebody3d = get_node(node_vehiclebody3D) as VehicleBody3D
@onready var _label := $Content/Title/Value as Label
@onready var _motion := $Content/Motion as HBoxContainer
@onready var _motion_engine_force := $Content/Motion/EngineForce/Value as Label
@onready var _motion_brake := $Content/Motion/Brake/Value as Label
@onready var _motion_steering := $Content/Motion/Steering/Value as Label
@onready var _rigidbody3d := $Content/RigidBody3D as HBoxContainer
@onready var _rigidbody3d_mass := $Content/RigidBody3D/Mass/Values/Value as Label
@onready var _rigidbody3d_center_of_mass := $Content/RigidBody3D/CenterOfMass/Values/Value as Label


func _ready() -> void:
	if not node_vehiclebody3D:
		TryToFindNodeInScene()
	hide_panels()
	if show_node_name:
		_label.text = "(" + _ref_vehiclebody3d.name + ")"


func TryToFindNodeInScene() -> void:
	for child in get_tree().current_scene.get_children(true):
		if child.get_class() == "VehicleBody3D":
			_ref_vehiclebody3d = child
			break
	assert(_ref_vehiclebody3d != null, "Add a ref to VehicleBody3D you want to track")


func hide_panels() -> void:
	if !show_motion:
		_motion.hide()
	if !show_rigidbody3d:
		_rigidbody3d.hide()


func format_float_str(value: float) -> String:
	return str(snapped(value, 0.01))


func _process(_d: float) -> void:
	if show_motion:
		_motion_engine_force.text = format_float_str(_ref_vehiclebody3d.engine_force)
		_motion_brake.text = format_float_str(_ref_vehiclebody3d.brake)
		_motion_steering.text = format_float_str(_ref_vehiclebody3d.steering)
	if show_rigidbody3d:
		_rigidbody3d_mass.text = format_float_str(_ref_vehiclebody3d.mass)
		_rigidbody3d_center_of_mass.text = format_float_str(_ref_vehiclebody3d.center_of_mass.y)


func _on_mass_slider_value_changed(value: float) -> void:
	_ref_vehiclebody3d.mass = value - 0.01


func _on_center_of_mass_slider_value_changed(value: float) -> void:
	_ref_vehiclebody3d.center_of_mass.y = value
