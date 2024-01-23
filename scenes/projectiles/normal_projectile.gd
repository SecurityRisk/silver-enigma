class_name NormalProjectile
extends ProjectileBase

var target:EnemyBase
@export var speed = 1500
var direction:Vector2

@onready var collision_cast:RayCast2D = $CollisionCast
@onready var HitExplosion = preload("res://scenes/particles/hit_explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if (!damage_resource):
		damage_resource = Damage.new()
		damage_resource.damage = randi_range(5, 30000)
	target = _get_closest_enemy()
	direction = position.direction_to(target.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (Game.is_off_screen(self)):
		queue_free()
	# Make sure the target is still alive. Otherwise the bullet won't change directions
	if target != null && target && !target.is_queued_for_deletion():
		# Move this node towards the target
		if (direction.distance_to(target.global_position) < 10):
			direction = (target.global_position - global_position).normalized()
		rotation = direction.angle()
		
	collision_cast.target_position = (direction * speed * delta)
	if (collision_cast.is_colliding()):
		_on_body_entered(collision_cast.get_collider(), collision_cast.get_collision_point())
	global_position += direction * speed * delta


func _on_body_entered(body, collision_point = Vector2(0, 0)):
	if (is_queued_for_deletion()):
		return
	if (body == target):
		var enemy = body as EnemyBase
		enemy.take_damage(damage_resource)
		visible = false
		var explosion = HitExplosion.instantiate() as GPUParticles2D
		if (collision_cast.is_colliding()):
			collision_point = collision_cast.get_collision_point()
		explosion.global_position = collision_point
		get_tree().root.add_child(explosion)
		explosion.finished.connect(explosion.queue_free)
		explosion.emitting = true
		queue_free()
# poo poo pee pee i love you
