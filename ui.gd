extends Control

@export var ne: NinePatchRect

@export var Animation_player: AnimationPlayer


enum  STATE {ne}
var ui_state = STATE




func _input(event):
	if event.is_action_pressed("ui pois") and not Animation_player.is_playing():
		match ui_state:
			STATE.ne:
				if ne.visible == true:
					Animation_player.play("ui_pois")
					get_tree().paused = false
				else:
					Animation_player.play("ui.näkyy")
	
					
	
		
func hide_and_show(first : String, second : String):
	Animation_player.play("ui_" + first)
	await  Animation_player.animation_finished
	Animation_player.play("ui." + second)


func _on_button_pressed() -> void:
	Animation_player.play("ui_pois")
	get_tree().paused = false
	
	


func _on_button_2_pressed() -> void:
	print("pussy") # Replace with function body.


func _on_button_3_pressed() -> void:
	get_tree().quit()
	
