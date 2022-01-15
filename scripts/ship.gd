extends StaticBody


func _on_Wood_Station_give(to: Player, item_scene: PackedScene) -> void:
	print("give item to player")
	var item := item_scene.instance()
	to.item = item
