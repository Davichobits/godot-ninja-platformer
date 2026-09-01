extends CharacterBody2D

@export var max_speed: = 120
@export var acceleration: = 1000
@export var air_acceleration: = 2000
@export var friction: = 1000
@export var air_friction: = 500
@export var up_gravity: = 500
@export var down_gravity: = 600
@export var jump_amount: = 200

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
		velocity.y += up_gravity * delta
		animation_player_lower.play("jump")
	
	# accelerate_horizontally(x_input, delta)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_amount
	
	if Input.is_action_just_pressed("attack"):
		animation_player_upper.play("attack")
	
	if x_input != 0:
		animation_player_lower.play("run")
		anchor.scale.x = sign(x_input)
		accelerate_horizontally(x_input, delta)
	else:
		apply_friction(delta)
		animation_player_lower.play("stand")
		
	if not is_on_floor():	
		animation_player_lower.play("jump")
		
	move_and_slide()

func accelerate_horizontally(horizontal_direction: float, delta:float) -> void:
	var acceleration_amount: = acceleration
	if not is_on_floor(): acceleration_amount = air_acceleration
	velocity.x = move_toward(velocity.x, max_speed * horizontal_direction, acceleration_amount * delta * abs(horizontal_direction))
	
func apply_friction(delta) -> void:
	var friction_amonunt: = friction
	if not is_on_floor(): friction_amonunt = air_friction
	velocity.x = move_toward(velocity.x, 0.0, friction_amonunt * delta)
