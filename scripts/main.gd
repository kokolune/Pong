extends Node

func _ready() -> void:
	$StartTimer.start()

func new_game():
	$Player.start($StartPosition.position)
	$Enemy.start($EnemyStartPostion.position, get_node("Ball"))
	$Ball.start($BallStartPostion.position)
	
func _on_start_timer_timeout() -> void:
	new_game()
