extends Control


func _ready() -> void:
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		print("Running on a mobile web browser!")
	else:
		print("Running on a desktop web browser!")
