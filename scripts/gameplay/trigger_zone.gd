extends Area3D
class_name TriggerZone

#== SIGNALS
signal collision_node3d_entered(collider: Area3D, object: Node3D)
signal collision_node3d_exited(collider: Area3D, object: Node3D)

#== FUNCTIONS
func _ready() -> void:
	self.body_shape_entered.connect(_on_body_shape_entered)
	self.body_shape_exited.connect(_on_body_shape_exited)

func _on_body_shape_entered(_body_rid: RID, body: Node3D, _body_shape_index: int, _local_shape_index: int) -> void:
	collision_node3d_entered.emit(self, body)

func _on_body_shape_exited(_body_rid: RID, body: Node3D, _body_shape_index: int, _local_shape_index: int) -> void:
	collision_node3d_exited.emit(self, body)
