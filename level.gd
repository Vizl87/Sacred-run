extends Node2D

@export var player: CharacterBody2D

@export var ansa: Sprite2D


func _on__spike_area__body_entered(body: Node2D) -> void:
	ansa.hide()
	


	
