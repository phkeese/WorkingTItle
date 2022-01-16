extends Spatial


export(Array, String) var inputs
export var max_items := 3
export var duration := 20.0


func _process(delta: float) -> void:
	$Station.health -= delta / duration


func add_item() -> void:
	$Station.health += 1.0 / max_items


func _on_Station_interacted_with(by: Player, item: Item) -> void:
	if item and item.item_name in inputs:
		add_item()
		by.rpc("remove_item")


func get_health() -> float:
	return $Station.health as float


func reset():
	$Station.health = 1.0
