extends Node3D

@onready var _mesh = $Mesh as MeshInstance3D
@onready var _label_title = $LabelTitle as Label3D
@onready var _label_interaction = $LabelInteraction as Label3D
@onready var _animation = $AnimationPlayer as AnimationPlayer
@onready var _audio_effect = $AudioEffect as AudioStreamPlayer
@export var popup_id : GameData.Popups
@export var placeholder := "Title"
@export var interaction_color := Color("#00ccdc")

var player_nearby : bool
var acc : float


func _ready() -> void:
	_mesh.mesh = _mesh.mesh.duplicate(true)
	_label_title.text = placeholder
	_label_interaction.visible = false


func _process(delta: float) -> void:
	if player_nearby:
		acc = 0
		change_colors(interaction_color);
	else:
		acc += delta
		var variation = 1 - abs(sin(acc)) / 1.5
		change_colors(Color(interaction_color.r, variation, interaction_color.b));


func change_colors(color: Color) -> void:
	_mesh.mesh.material.albedo_color = color
	_label_interaction.modulate = color


func _on_area_3d_body_shape_entered(_br: RID, body: Node3D, _bsi: int, _lsi: int) -> void:
	if body is PlayerCar:
		_animation.play("enter")
		_audio_effect.play()
		_label_interaction.visible = true
		player_nearby = true
		GameData.on_popup_id = popup_id


func _on_area_3d_body_shape_exited(_br: RID, body: Node3D, _bsi: int, _lsi: int) -> void:
	if body is PlayerCar:
		_animation.play("enter")
		_label_interaction.visible = false
		player_nearby = false
		GameData.on_popup_id = 0
