extends Spatial


export var max_angle := 20.0


func _process(delta: float) -> void:
	var center := Vector3.ZERO
	for player in $Players.get_children():
		center += player.global_transform.origin * Vector3(1.0, 0.0, 1.0)
	center /= $Players.get_child_count()
	$MeshInstance.global_transform.origin = center + Vector3.UP * 3.0
