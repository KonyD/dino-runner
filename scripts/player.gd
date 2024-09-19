extends CharacterBody2D

var gravity = 1200  
var jump_force = -600  

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = %Timer
@onready var score_timer = %ScoreTimer

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$Jump.play()
		velocity.y = jump_force
	
	# Handle Bend Down.
	if Global.game_over == false:
		if Input.is_action_pressed("ui_down"):
			animated_sprite_2d.play("bend_down")
			$Area2D/RuningCollision.disabled = true
			$Area2D/BendingCollision.disabled = false
		else:
			animated_sprite_2d.play("run")
			$Area2D/RuningCollision.disabled = false
			$Area2D/BendingCollision.disabled = true
	
	move_and_slide()


func _on_area_2d_area_entered(area):
	$Death.play()
	Global.game_over = true
	timer.stop()
	score_timer.stop()
	Engine.time_scale = 0.5
	animated_sprite_2d.play("death")
	$CollisionShape2D.queue_free()
