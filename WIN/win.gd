extends Control

@export var win: NinePatchRect


func _on_button_pressed() -> void:
	get_tree().quit()
