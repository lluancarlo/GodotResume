extends Node

signal interactive_pressed()

var isMobile : bool
var axisX : float
var axisY : float


func _ready() -> void:
	isMobile = OS.has_feature("web_android") or OS.has_feature("web_ios")


func _physics_process(_delta: float) -> void:
	axisX = Input.get_axis("right", "left")
	axisY = Input.get_axis("back", "forward")
	
	if Input.is_action_just_pressed("interactive"):
		interactive_pressed.emit()
