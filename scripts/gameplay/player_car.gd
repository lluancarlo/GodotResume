extends VehicleBody3D
class_name PlayerCar

#== SIGNALS
signal gear_changed(gear: int)
signal speed_changed(speed: int)

#== NODES
@onready var _wheel_fl := $WheelFL as VehicleWheel3D
@onready var _wheel_fr := $WheelFR as VehicleWheel3D
@onready var _audio_engine := $AudioEngine as AudioStreamPlayer3D
@onready var _audio_impact := $AudioImpact as AudioStreamPlayer3D

#== VARIABLES
var initial_position : Vector3
var max_rpm := 8000
var max_torque := mass * 2.0
var previous_velocity : float
var previous_gear : int
var previous_speed : int

#== FUNCTIONS
func _ready() -> void:
	initial_position = position

func _physics_process(delta: float) -> void:
	var current_rpm = get_rpm()
	var acceleration = Input.get_axis("back", "forward")
	
	# Limit reverse speed
	if current_rpm < 0 && linear_velocity.length() > 3:
		acceleration = 0

	if GameData.can_drive:
		var axis_x =  Input.get_axis("right", "left")
		var max_steering = 0.8 - (linear_velocity.length() / 30.0)	
		steering = lerp(steering, axis_x * max_steering, 6 * delta)
		engine_force = acceleration * max_torque * ( 1 - current_rpm / max_rpm)
	else:
		linear_velocity = Vector3.ZERO

	# Engine sound
	var rpm = ((abs(current_rpm) / 100) + 1) / 5
	var gear = rpm / 0.2
	var new_pitch = lerp(0.2 if int(gear) == 1 else 0.45, 0.7, gear - int(gear))
	_audio_engine.pitch_scale = lerpf(_audio_engine.pitch_scale, new_pitch, 0.2)

	# Impact sound
	if GameData.can_drive && abs(linear_velocity.length() - previous_velocity) > 1.0:
		_audio_impact.play()

	# Back light
	set_break_light(acceleration < 0)

	update_gear(0 if current_rpm < 0 else gear)
	update_speed(int(linear_velocity.length() * 10 ))
	previous_velocity = linear_velocity.length()

func update_gear(gear: int) -> void:
	if gear != previous_gear:
		gear_changed.emit(gear)
		previous_gear = gear

func update_speed(speed: int) -> void:
	if speed != previous_speed:
		speed_changed.emit(speed)
		previous_speed = speed

func get_rpm() -> float:
	return (_wheel_fl.get_rpm() + _wheel_fr.get_rpm()) / 2.0

func set_break_light(_on: bool) -> void:
	pass #TODO

func reset_position() -> void:
	position = initial_position
	rotation = Vector3(0, 90, 0)
	linear_velocity = Vector3.ZERO
