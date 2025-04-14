extends Area2D
signal bounce
@export var speed = 5 #How fast enemy will move
var screen_size #Game's window size 
var offset
var enemy
var ball 
var ball_ready = false
var direction 

func _ready() -> void:
	screen_size = get_viewport_rect().size
	offset = $Sprite2D.get_scale()
	enemy = get_node(".")
	hide()

func _physics_process(delta: float) -> void:	
	if ball_ready:
		direction = ball.position.x - position.x 
		position.x += direction * delta * speed
		position = position.clamp(offset / 2, screen_size - offset / 2) # restrict enemy's position to screen size
		
func start(pos, ball_node):
	position = pos
	ball = ball_node
	ball_ready = true
	show()
	
func _on_area_entered(area: Area2D) -> void:
	if area != enemy:
		print("enemy bounce")
		bounce.emit(enemy)
