extends Spatial


func _on_give(to: Player, item_scene: PackedScene) -> void:
	var item := item_scene.instance()
	to.item = item
