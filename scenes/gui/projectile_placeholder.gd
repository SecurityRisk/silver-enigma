class_name ProjectilePlaceholder
extends CenterContainer

@export var projectile:ProjectileResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_projectile_change(proj:ProjectileResource):
	proj._preload_scene()
	projectile = proj
	var tex = $Placeholder/Projectile as TextureRect
	tex.texture = projectile.iconTexture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_fire_timer_timeout():
	if (!projectile.preloadedScene):
		projectile._preload_scene()
	var proj:ProjectileBase = projectile.preloadedScene.instantiate() as ProjectileBase
	proj.position = $ProjectileSpawnPoint.global_position
	proj.damage_resource = Damage.new()
	proj.damage_resource.damage = randi_range(2, 30)
	proj.init(projectile)
	get_tree().root.add_child(proj)


func _on_gui_input(event):
	# TODO: Check if it's the action instead of checking mouse button directly
	if (event is InputEventMouseButton):
		event = event as InputEventMouseButton
		if (event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed()):
			print("DFA")
	accept_event()
