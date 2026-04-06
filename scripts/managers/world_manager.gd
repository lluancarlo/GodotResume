extends Node3D
class_name WorldManager

#== SIGNALS
signal player_on_pickup(pickup_id: GameData.PickUps)
signal player_gear_change(gear: int)
signal player_speed_change(speed: int)
signal area3d_entered_area(area_name: String)

#== NODES
@onready var _player_car : PlayerCar = $PlayerCar


#== CONST
const AUDIO_BUS_GAME_NAME : String = "Game"  # Name of the audio bus
#== VARIABLES
var is_player_inside_area : bool
var _audio_bus_index : int = -1

#== FUNCTIONS
func _ready() -> void:
	push_warning("TEST 123")
	# Get audio bus index by name instead of hardcoding
	_audio_bus_index = AudioServer.get_bus_index(AUDIO_BUS_GAME_NAME)
	if _audio_bus_index == -1:
		push_warning("Audio bus '%s' not found" % AUDIO_BUS_GAME_NAME)
	else:
		AudioServer.set_bus_volume_db(_audio_bus_index, -80)

func effect_transition_in(duration: float) -> void:
	if _audio_bus_index == -1:
		return
	create_tween().tween_method(
		func(vol): AudioServer.set_bus_volume_db(_audio_bus_index, vol),
		-80, 0.0, duration).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

func reset_player_position() -> void:
	if _player_car != null:
		_player_car.reset_position()
	else:
		push_warning("Player car not found for reset")

#== SIGNAL FUNCTIONS
func _on_collision_node_3d_entered(collider: Area3D, object: Node3D) -> void:
	if object is PlayerCar and not is_player_inside_area:
		is_player_inside_area = true
		area3d_entered_area.emit(collider.name)

func _on_collision_node_3d_exited(_collider: Area3D, object: Node3D) -> void:
	if object is PlayerCar and is_player_inside_area:
		is_player_inside_area = false

func _on_collision_pickup(pickup_id: GameData.PickUps) -> void:
	player_on_pickup.emit(pickup_id)

func _on_player_car_gear_changed(gear: int) -> void:
	player_gear_change.emit(gear)

func _on_player_car_speed_changed(speed: int) -> void:
	player_speed_change.emit(speed)
