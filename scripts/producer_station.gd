class_name SpawningStation
extends Spatial
signal give(to, item_scene)


export var item_scene : PackedScene
export var max_interactions := 10
export var interactions := 0 setget _set_interactions


var _last_player : Player


onready var _station := $Station


func _process(delta: float) -> void:
	if interactions >= max_interactions:
		self.interactions = 0
		emit_signal("give", _last_player, item_scene)
		


func interact(player: Node):
	self.interactions += 1
	_last_player = player


func _set_interactions(new: int) -> void:
	interactions = clamp(new, 0, max_interactions)
	_station.health = float(interactions) / max_interactions


func _on_Station_interacted_with(by: Player, item: Spatial) -> void:
	interact(by)
