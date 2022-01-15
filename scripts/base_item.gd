extends RigidBody


var parent_node : Spatial


func _physics_process(delta: float) -> void:
	if parent_node:
		mode = RigidBody.MODE_STATIC
