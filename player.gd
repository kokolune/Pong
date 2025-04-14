extends Area2D
@export var speed = 400 #How fast player will move
var screen_size #Game's window size 
var offset #Player model offset to restrict movement beyond screen borders
signal bounce 
var player 

func _ready() -> void:
	offset = $Sprite2D.get_scale()
	player = get_node(".")
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # Player's movement vector
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1	
	if velocity.length() > 0:
		velocity = velocity * speed
	position += velocity * delta 
	position = position.clamp(offset / 2, screen_size - offset / 2) # restrict player's position to screen size

func start(pos):
	position = pos
	show()

func _on_area_entered(area: Area2D) -> void:
	if area != player:
		print("player bounce")
		bounce.emit(player)
