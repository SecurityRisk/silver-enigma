class_name ProjectileResource
extends Resource

enum Type {
	NORMAL,
	LASER
}

var dict:Dictionary = {
	Type.NORMAL: "res://scenes/projectiles/normal_projectile.tscn",
	Type.LASER: ""
	}

@export var type:Type

@export var icon_texture:Texture2D

# TODO: Remove @export once we implement components
# This array will be updated whenever something is added or removed
@export var components:Array = []

# This damage will have side effects as it will be updated
var damage_resource:Damage = Damage.new()

var preloaded_scene

func _preload_scene():
	preloaded_scene = load(dict.get(type))
	
func calculate_flat_damage() -> int:
	var dms:Array[DamageModifier] = []
	for component in components:
		if component is DamageModifier:
			dms.append(component)
	damage_resource.damage_modifiers = dms
	return damage_resource._get_total_damage()
