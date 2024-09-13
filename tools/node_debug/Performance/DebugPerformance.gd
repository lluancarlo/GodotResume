extends Node
class_name DebugPerformance


@onready var _nodes := $VBox/Nodes/Value as Label
@onready var _resources := $VBox/Resources/Value as Label
@onready var _primitives := $VBox/Primitives/Value as Label
@onready var _draw_calls := $VBox/DrawCalls/Value as Label
@onready var _video_memory := $VBox/VideoMemUsed/Value as Label


func _process(_d: float) -> void:
	_nodes.text = "%d" % Performance.get_monitor(Performance.OBJECT_NODE_COUNT)
	_resources.text = "%d" % Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT)
	_primitives.text = "%d" % Performance.get_monitor(Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME)
	_draw_calls.text = "%d" % Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
	_video_memory.text = "%dMb" % (Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED) / pow(2,20))
