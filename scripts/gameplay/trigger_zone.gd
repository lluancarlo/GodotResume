extends Area3D
class_name TriggerZone


signal collision_node3d_entered(collider: Area3D, object: Node3D)
signal collision_node3d_exited(collider: Area3D, object: Node3D)


func _ready() -> void:
	self.body_shape_entered.connect(_on_body_shape_entered)
	self.body_shape_exited.connect(_on_body_shape_exited)


func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	collision_node3d_entered.emit(self, body)


func _on_body_shape_exited(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	collision_node3d_exited.emit(self, body)
