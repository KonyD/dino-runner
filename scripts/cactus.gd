extends Area2D

var speed = 500 

@onready var sprite = $Sprite2D

# Select random sprite region.
func _ready():
	var sprite_regions = [Vector2(1, 0), Vector2(21, 0), Vector2(41, 0), Vector2(61, 0), Vector2(81, 0), Vector2(101, 0)]
	
	randomize()
	var random_index = randi() % sprite_regions.size()
	var region = sprite_regions[random_index]
	
	sprite.region_rect.position = region

# Move the node.
func _process(delta):
	position.x -= speed * delta

# Delete the node when exited screen.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
