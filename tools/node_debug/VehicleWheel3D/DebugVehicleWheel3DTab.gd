extends TabBar
class_name DebugVehicleWheel3DTab

signal wheel_rollinfluence_changed(value)
signal wheel_radius_changed(value)
signal wheel_restlength_changed(value)
signal wheel_frictionslip_changed(value)
signal suspension_travel_changed(value)
signal suspension_stiffness_changed(value)
signal suspension_maxforce_changed(value)
signal damping_compression_changed(value)
signal damping_relaxation_changed(value)

@export var tab_title : String
@onready var pw_title := $Content/Label as Label
@onready var pw_motion := $Content/Scroll/Content/PerWheelMotion as VBoxContainer
@onready var pw_motion_engine_force := $Content/Scroll/Content/PerWheelMotion/EngineForce/Value as Label
@onready var pw_motion_brake := $Content/Scroll/Content/PerWheelMotion/Brake/Value as Label
@onready var pw_motion_steering := $Content/Scroll/Content/PerWheelMotion/Steering/Value as Label
@onready var wheel := $Content/Scroll/Content/Wheel as VBoxContainer
@onready var wheel_rollinfluence := $Content/Scroll/Content/Wheel/RollInfluence/Values/Value as Label
@onready var wheel_rollinfluence_slider := $Content/Scroll/Content/Wheel/RollInfluence/Values/HSlider as HSlider
@onready var wheel_radius := $Content/Scroll/Content/Wheel/Radius/Values/Value as Label
@onready var wheel_radius_slider := $Content/Scroll/Content/Wheel/Radius/Values/HSlider as HSlider
@onready var wheel_restlength := $Content/Scroll/Content/Wheel/RestLength/Values/Value as Label
@onready var wheel_restlength_slider := $Content/Scroll/Content/Wheel/RestLength/Values/HSlider as HSlider
@onready var wheel_frictionslip := $Content/Scroll/Content/Wheel/FrictionSlip/Values/Value as Label
@onready var wheel_frictionslip_slider := $Content/Scroll/Content/Wheel/FrictionSlip/Values/HSlider as HSlider
@onready var suspension := $Content/Scroll/Content/Suspension as VBoxContainer
@onready var suspension_travel := $Content/Scroll/Content/Suspension/Travel/Values/Value as Label
@onready var suspension_travel_slider := $Content/Scroll/Content/Suspension/Travel/Values/HSlider as HSlider
@onready var suspension_stiffness := $Content/Scroll/Content/Suspension/Stiffness/Values/Value as Label
@onready var suspension_stiffness_slider := $Content/Scroll/Content/Suspension/Stiffness/Values/HSlider as HSlider
@onready var suspension_maxforce := $Content/Scroll/Content/Suspension/MaxForce/Values/Value as Label
@onready var suspension_maxforce_slider := $Content/Scroll/Content/Suspension/MaxForce/Values/HSlider as HSlider
@onready var damping := $Content/Scroll/Content/Damping as VBoxContainer
@onready var damping_compression := $Content/Scroll/Content/Damping/Compression/Values/Value as Label
@onready var damping_compression_slider := $Content/Scroll/Content/Damping/Compression/Values/HSlider as HSlider
@onready var damping_relaxation := $Content/Scroll/Content/Damping/Relaxation/Values/Value as Label
@onready var damping_relaxation_slider := $Content/Scroll/Content/Damping/Relaxation/Values/HSlider as HSlider


func _ready() -> void:
	if tab_title.strip_escapes().length() > 0:
		pw_title.text = "  " + tab_title


func set_wheel(roll_influence: float, radius: float, rest_length: float, friction_slip: float) -> void:
	wheel_rollinfluence_slider.value = roll_influence
	wheel_radius_slider.value = radius
	wheel_restlength_slider.value = rest_length
	wheel_frictionslip_slider.value = friction_slip


func set_suspension(travel: float, stiffness: float, max_force: float) -> void:
	suspension_travel_slider.value = travel
	suspension_stiffness_slider.value = stiffness
	suspension_maxforce_slider.value = max_force


func set_damping(compression: float, relaxation: float) -> void:
	damping_compression_slider.value = compression
	damping_relaxation_slider.value = relaxation


func _on_wheel_rollinfluence_slider_value_changed(value: float) -> void:
	wheel_rollinfluence_changed.emit(value)


func _on_wheel_radius_slider_value_changed(value: float) -> void:
	wheel_radius_changed.emit(value)


func _on_wheel_restlength_slider_value_changed(value: float) -> void:
	wheel_restlength_changed.emit(value)


func _on_wheel_flictionslip_slider_value_changed(value: float) -> void:
	wheel_frictionslip_changed.emit(value)


func _on_suspension_travel_slider_value_changed(value: float) -> void:
	suspension_travel_changed.emit(value)


func _on_suspension_stiffness_slider_value_changed(value: float) -> void:
	suspension_stiffness_changed.emit(value)


func _on_suspension_maxforce_slider_value_changed(value: float) -> void:
	suspension_maxforce_changed.emit(value)


func _on_damping_compression_slider_value_changed(value: float) -> void:
	damping_compression_changed.emit(value)


func _on_damping_relaxation_slider_value_changed(value: float) -> void:
	damping_relaxation_changed.emit(value)
