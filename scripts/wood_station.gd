extends Spatial


export var max_interactions := 10
export var interactions := 0 setget _set_interactions


onready var _station := $Station


func _process(delta: float) -> void:
	if interactions >= max_interactions:
		self.interactions = 0
		print("spawn wood")


func interact(player: Node):
	print("increment wood")
	self.interactions += 1


func _set_interactions(new: int) -> void:
	interactions = clamp(new, 0, max_interactions)
	_station.health = float(interactions) / max_interactions


func _on_Station_interacted_with(by: Player) -> void:
	interact(by)
