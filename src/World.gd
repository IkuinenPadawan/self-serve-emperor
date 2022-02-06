extends Node2D

#onready var nav_2d = $Navigation2D
#onready var line_2d = $Line2D
#onready var customer = $Customer
#
#func _unhandled_input(event: InputEvent) -> void:
#	if not event is InputEventMouseButton:
#		return
#	if event.button_index != BUTTON_LEFT or not event.pressed:
#		return
#
#	var new_path : = nav_2d.get_simple_path(customer.global)

func _ready() -> void:
	randomize()
