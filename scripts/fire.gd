extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Station_entered(by) -> void:
	if not is_network_master():
		return
	if not by is Player:
		return
	var item = by.item
	if item and item.item_name == "water":
		return
	else:
		by.rpc("kill")


func _on_Station_interacted_with(by, item) -> void:
	if item and item.item_name == "water":
		by.rpc("remove_item")
		$Sync.remove()
