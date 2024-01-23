class_name ProjectileBase
extends Area2D

var projectile_resource:ProjectileResource
var damage_resource:Damage

func init(resource:ProjectileResource):
	projectile_resource = resource

func _get_closest_enemy() -> EnemyBase:
	var enemies:Array[EnemyBase] = get_all_enemies()
	var closest_node = null
	var min_distance = INF  # INF is a constant representing 'infinity'

	for node in enemies:
		var distance = global_position.distance_to(node.global_position)
		if distance < min_distance:
			min_distance = distance
			closest_node = node

	return closest_node

func get_all_enemies()-> Array[EnemyBase]:
	var enemies:Array[Node] = get_tree().get_nodes_in_group("enemies") as Array[Node]
	var returned_enemies:Array[EnemyBase] = []
	for i in enemies:
		if i is EnemyBase : returned_enemies.append(i)
	return returned_enemies
