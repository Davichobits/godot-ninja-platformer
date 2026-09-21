class_name Hurtbox extends Area2D

var is_invincible: = false

signal hurt(other_hitbox: Hitbox)

func takehit(other_hitbox: Hitbox) -> void:
	if is_invincible: return
	hurt.emit(other_hitbox)
