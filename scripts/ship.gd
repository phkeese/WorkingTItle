extends StaticBody


func _on_Wood_Station_give(to: Player, item_scene: PackedScene) -> void:
	rpc("give", to.get_path(), item_scene)


remotesync func give(to: NodePath, item_scene: PackedScene):
	print("give item to player")
	var item := item_scene.instance()
	var player := get_node(to)
	player.item = item
