extends Control
class_name MobileAxis

#== SIGNALS
signal joystick_moved(direction: Vector2)

#== NODES
@onready var _back : TextureRect = $Back
@onready var _knob : TextureRect = $Knob

#== EXPORTS
@export var radius: float = 50

#== VARIABLES
var knob_origin  := Vector2.ZERO
var dragging := false
var last_direction := Vector2.ZERO

#== FUNCTIONS
func _ready():
	knob_origin = (_back.size / 2) - (_knob.size / 2)

func visual_change(pressed: bool) -> void:
	_back.modulate.a = 0.5 if pressed else 1.0
	_knob.modulate.a = 0.5 if pressed else 1.0

#== SIGNAL FUNCTIONS
func _on_back_gui_input(event: InputEvent) -> void:
	if (event is InputEventScreenDrag or (event is InputEventScreenTouch and event.pressed)):
		var center = _back.size / 2
		var local_pos = event.position - center
		
		if local_pos.length() > radius:
			local_pos = local_pos.normalized() * radius
		
		_knob.position = center + local_pos - (_knob.size / 2)
		
		var direction = round(local_pos / radius / 0.1) * 0.1
		if direction != last_direction:
			joystick_moved.emit(direction)
			last_direction = direction
			visual_change(true)
	
	elif event is InputEventScreenTouch and not event.pressed:
		_knob.position = knob_origin
		
		var direction = Vector2.ZERO
		if direction != last_direction:
			joystick_moved.emit(direction)
			last_direction = direction
			visual_change(false)
