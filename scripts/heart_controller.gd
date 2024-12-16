extends Panel

@export var player: CharacterBody2D

@export var h1: AnimatedSprite2D
@export var h2: AnimatedSprite2D
@export var h3: AnimatedSprite2D

@onready var animation_finished: bool = false

func _ready() -> void:
	h1.connect("animation_finished", Callable(self, "_on_AnimatedSprite_animation_finished"))
	h2.connect("animation_finished", Callable(self, "_on_AnimatedSprite_animation_finished"))
	h3.connect("animation_finished", Callable(self, "_on_AnimatedSprite_animation_finished"))



func _on_health_changed():
	
	if player.currenthealth == 3:
		h1.show()
		h2.show()
		h3.show()
		
		
	if player.currenthealth == 2 && !animation_finished:
		h1.play("hearts")
		h2.play("hearts")
		h3.play("hearts")
		
		
		h1.hide()
	if player.currenthealth == 1 && !animation_finished:
		h1.play("hearts")
		h3.play("hearts")
		
		h2.hide()
		
		
func _on_AnimatedSprite_animation_finished():
	h1.stop()
	h2.stop()
	h3.stop()
	
	
	animation_finished = true
	
