extends Node3D

enum Arrow { LEFT, RIGHT }
@onready var _label := $Text as Label3D
@onready var _arrow := $Arrow as Label3D
@export var text : String
@export var direction : Arrow
@export var interaction_color := Color("#00ccdc")
var acc : float


func _ready() -> void:
	_label.text = text
	_arrow.text = '<<<' if direction == Arrow.LEFT else '>>>'


func _process(delta: float) -> void:
	acc += delta
	var variation = 1 - abs(sin(acc)) / 1.5
	_arrow.modulate = Color(interaction_color.r, variation, interaction_color.b)
