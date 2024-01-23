class_name Damage
extends Resource

@export var damage := 0

# Damage Modifiers are things that add flat damage
@export var damage_modifiers:Array[DamageModifier] = []

# Add status effects and other things

func _get_total_damage() -> int:
	var tots := damage
	for modifier in damage_modifiers:
		tots = modifier.run_calc(tots)
	return tots
