extends Node

func display_number(value:int, position:Vector2, is_critical: bool = false):
	var number = Label.new()
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = '#FFF'
	if (is_critical):
		color = "#B22"
	if (value == 0):
		color = "#FFF8"
	
	number.label_settings.font = load("res://assets/fonts/joystix monospace.otf")
	number.label_settings.font_color = color
	number.label_settings.font_size = 30
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 5
	number.label_settings.shadow_color = "#000"
	number.label_settings.shadow_size = 8
	number.label_settings.shadow_offset = Vector2(2, 2)
	number.horizontal_alignment = 1
	number.vertical_alignment = 1
	number.set_anchors_preset(Control.PRESET_CENTER)
	number.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	number.size_flags_horizontal = Control.SIZE_FILL
	
	call_deferred("add_child", number)
	
	await number.resized
	number.global_position = position - (number.size / 2)
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, "position:y", number.position.y - randi_range(40, 100), .25).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(number, "position:y", number.position.y, .25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUINT).set_delay(.25)
	tween.tween_property(number, "position:x", number.position.x + randf_range(-60, 60), .5)
	#tween.tween_property(number, "scale", Vector2.ZERO, .25).set_ease(Tween.EASE_IN).set_delay(.5)
	
	await tween.finished
	number.queue_free()
