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

@export var iconTexture:Texture2D

@export var affixes:Array = []

var preloadedScene

func _preload_scene():
	preloadedScene = load(dict.get(type))

func _get_scene():
	return dict.get(type)
