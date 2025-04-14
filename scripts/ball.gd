extends Area2D
@export var speed : int #How fast ball will move
var screen_size #Game's window size 
var velocity = Vector2.DOWN # Start game with ball going down
var ball_id
var speed_modifier = 1

func _ready() -> void:
	screen_size = get_viewport_rect().size
	ball_id = get_instance_id()
	hide()

func _physics_process(delta: float) -> void:
	position += velocity * speed * delta * speed_modifier

func start(pos):
	position = pos
	show()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	position = screen_size / 2 # Reset ball position after scoring
	speed_modifier = 1
	if velocity.y < 0: # Reset ball velocity depending on who lost the score
		velocity = Vector2.UP
	else:
		velocity = Vector2.DOWN
	
func _on_right_wall_area_entered(area: Area2D) -> void:
	if area.get_instance_id() == ball_id:
		velocity.x *= -1
	else:
		pass

func _on_left_wall_area_entered(area: Area2D) -> void:
	if area.get_instance_id() == ball_id:
		velocity.x *= -1
	else:
		pass

func _on_player_bounce(player) -> void:
	# randomise angle depenging on which part of the platform ball landed
	if player.position.x + 32 < position.x:
		velocity.x += randf_range(0.1, 0.5)
	elif player.position.x - 32 > position.x:
		velocity.x += -randf_range(0.1, 0.5)
	velocity.y *= -1
	speed_modifier += 0.1
	
func _on_enemy_bounce(enemy) -> void:
	if enemy.position.x + 32 < position.x:
		velocity.x += randf_range(0.1, 0.5)
	elif enemy.position.x - 32 > position.x:
		velocity.x += -randf_range(0.1, 0.5)
	velocity.y *= -1
	speed_modifier += 0.1
