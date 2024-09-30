extends CharacterBody2D

var speed = 50 #pixels per second

var player_state = "idle"
var game_state = "idle"
var direction = Vector2i(0, 0)
var player_pos
var target_pos

func _ready():
	var tilemap = $"../TileMap"
	var rect = tilemap.get_used_rect()
	
	player_pos = Vector2((rect.position.x + 3) * 40 + 10, (rect.position.y + 2) * 40 - 10)
	position = player_pos

func _physics_process(delta: float) -> void:
	if game_state == "idle":
		direction = Input.get_vector("left", "right", "up", "down")
		
		if direction.x == 0 and direction.y == 0:
			player_state = "idle"
		elif direction.x != 0 or direction.y != 0:
			player_state = "walking"
			game_state = "walking_animation"
			direction = Vector2(direction.x, 0) if direction.x else Vector2(0, direction.y)
			target_pos = player_pos + direction*40 
			
	elif game_state == "walking_animation":
		if (target_pos.x - player_pos.x)*direction.x < 0 or (target_pos.y - player_pos.y)*direction.y < 0:
			game_state = "idle"
			player_state = "idle"
			player_pos = target_pos
		else:
			player_pos = Vector2(speed*delta*direction.x, speed*delta*direction.y) + player_pos
	
	position = player_pos
	play_anim()
	
func play_anim():
	if player_state == 'idle' and game_state == "idle":
		$AnimatedSprite2D.play("idle")
	
	if player_state == "walking" and game_state == "walking_animation":
		if direction.y == -1:
			$AnimatedSprite2D.play("walk_n")
		if direction.x == -1:
			$AnimatedSprite2D.play("walk_w")
		if direction.y == 1:
			$AnimatedSprite2D.play("walk_s")
		if direction.x == 1:
			$AnimatedSprite2D.play("walk_e")
