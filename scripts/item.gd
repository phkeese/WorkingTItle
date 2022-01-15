class_name Item
extends Spatial


export var item_name := "Item"


func _network_ready(is_source):
	self.global_transform = global_transform
