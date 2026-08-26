extends CharacterBody2D

const PLAYER_SPEED: int = 120

@onready var animation_player_upper: AnimationPlayer = $AnimationPlayerUpper
@onready var animation_player_lower: AnimationPlayer = $AnimationPlayerLower

func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis("left", "right")
	velocity.x = x_input * PLAYER_SPEED
	
	if x_input != 0:
		animation_player_lower.play("run")
		animation_player_upper.play("run")
	else:
		animation_player_lower.play("stand")
		animation_player_upper.play("stand")
		
	move_and_slide()
