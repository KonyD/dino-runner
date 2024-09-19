extends Node2D

@onready var label = $Label
@onready var label2 = $Label2
@onready var sprite_2d = $Sprite2D
@onready var timer = $Timer
@onready var animated_sprite = $Player/AnimatedSprite2D
@onready var collision_shape = $Player/CollisionShape2D
@onready var score_timer = $ScoreTimer
@onready var score_label = $ScoreLabel
@onready var high_score_label = $HighScoreLabel

# Preload obstacle scenes.
var cactus_scene = preload("res://scenes/cactus.tscn")
var enemy_scene = preload("res://scenes/enemy.tscn")
var obstacle_types := [cactus_scene, enemy_scene]
var obstacles : Array

func _ready():
	# Restart the scene.
	if Global.restarted == true:
		label.visible = false
		spawn_obstacle()
		timer.start()
		Global.score = 0
		score_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and Global.menu == true:
		label.visible = false
		spawn_obstacle()
		timer.start()
		score_timer.start()
		Global.menu = false
	elif Input.is_action_just_pressed("ui_accept") and Global.game_over == true:
		Global.restarted = true
		Global.game_over = false
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()
	elif Global.game_over == true:
		if Global.score > Global.high_score:
			Global.high_score = Global.score
		high_score_label.text = "High score: " + str(Global.high_score)
		label2.visible = true
		high_score_label.visible = true
		sprite_2d.visible = true
	
	score_label.text = str(Global.score)

# Call the "spawn_obstacle" function every 1.4 seconds.
func _on_timer_timeout():
	spawn_obstacle()

# Spawn a random obstacle scene.
func spawn_obstacle():
	var obstacle_type = obstacle_types[randi() % obstacle_types.size()]
	var obstacle = obstacle_type.instantiate()
	
	add_child(obstacle)

# Increase the score by one every 0.5 seconds.
func _on_score_timer_timeout():
	Global.score += 1
