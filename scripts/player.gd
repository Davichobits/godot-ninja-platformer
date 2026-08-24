extends CharacterBody2D

func _physics_process(delta: float) -> void:
	#if Input.is_action_pressed("ui_right"):
		#velocity.x = 50
	#if Input.is_action_pressed("ui_left"):
		#velocity.x = -50
	var x_input = Input.get_axis("ui_left", "ui_right")
	velocity.x = x_input * 50
	move_and_slide()
