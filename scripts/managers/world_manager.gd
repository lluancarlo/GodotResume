extends Node3D
class_name WorldManager

#== SIGNALS
signal player_on_pickup(pickup_id: GameData.PickUps)
signal player_gear_change(gear: int)
signal player_speed_change(speed: int)
signal area3d_entered_area(area_name: String)

#== NODES
@onready var _player : PlayerCar = $PlayerCar

#== CONST
const AUDIO_BUS_GAME : int = 2

#== VARIABLES
var is_player_inside_area : bool

#== FUNCTIONS
func _ready() -> void:
	AudioServer.set_bus_volume_db(AUDIO_BUS_GAME, -80)

func effect_transition_in(duration: float) -> void:
	create_tween().tween_method(
		func(vol): AudioServer.set_bus_volume_db(AUDIO_BUS_GAME, vol),
		-80, 0.0, duration).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

func reset_player_position() -> void:
	_player.reset_position()

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
