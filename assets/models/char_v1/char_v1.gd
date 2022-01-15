extends Spatial


export var tint : Color
export var material : SpatialMaterial


func _ready() -> void:
	$Icosphere001.material_override = material
	$Icosphere002.material_override = material
	material.albedo_color = tint
