extends CharacterBody2D

const PLAYER_SPEED: int = 120
const GRAVITY: int = 500

@onready var animation_player_upper: AnimationPlayer = $AnimationPlayerUpper
@onready var animation_player_lower: AnimationPlayer = $AnimationPlayerLower
@onready var anchor: Node2D = $Anchor

func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis("left", "right")
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		animation_player_lower.play("jump")
		animation_player_upper.play("jump")
	
	velocity.x = x_input * PLAYER_SPEED
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -200
	
	if x_input != 0:
		animation_player_lower.play("run")
		animation_player_upper.play("run")
		anchor.scale.x = sign(x_input)
	else:
		animation_player_lower.play("stand")
		animation_player_upper.play("stand")
		
	if not is_on_floor():	
		animation_player_lower.play("jump")
		animation_player_upper.play("jump")
		
	move_and_slide()
