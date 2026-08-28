extends CharacterBody2D

const PLAYER_SPEED: int = 120
const GRAVITY: int = 500

@onready var animation_player_upper: AnimationPlayer = $AnimationPlayerUpper
@onready var animation_player_lower: AnimationPlayer = $AnimationPlayerLower
@onready var anchor: Node2D = $Anchor

func _ready() -> void:
	animation_player_lower.current_animation_changed.connect(func(animation_name: String):
		if animation_player_upper.current_animation == "attack": return
		animation_player_upper.play(animation_name)
	)
	
	animation_player_upper.animation_finished.connect(func(animation_name: String):
		if animation_name != "attack": return
		animation_player_upper.play(animation_player_lower.current_animation)
		animation_player_upper.seek(animation_player_lower.current_animation_position)
	)

func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis("left", "right")
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		animation_player_lower.play("jump")
	
	velocity.x = x_input * PLAYER_SPEED
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -200
	
	if Input.is_action_just_pressed("attack"):
		animation_player_upper.play("attack")
	
	if x_input != 0:
		animation_player_lower.play("run")
		anchor.scale.x = sign(x_input)
	else:
		animation_player_lower.play("stand")
		
	if not is_on_floor():	
		animation_player_lower.play("jump")
		
	
		
	move_and_slide()
