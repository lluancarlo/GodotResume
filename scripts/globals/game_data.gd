extends Node
#class_name GameData

#== ENUMS
enum PickUps
{
	None = 0,
	Warning = 1,
	Born = 2,
	Live = 3,
	University = 4,
	Consinco = 5,
	Magit = 6,
	TopGaming = 7,
	DeltaEngine = 8,
	Amilon = 9
}

#== VARIABLES
var is_mobile : bool
var can_drive : bool
var mission_1_count : int
var mission_2_count : int
var pickups_done : Array[int] = []

#== FUNCTION
func _ready() -> void:
	is_mobile = OS.has_feature("web_android") or OS.has_feature("web_ios")
