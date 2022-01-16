extends Spatial


func reset():
	for child in get_children():
		child.get_node("Sync").remove()
