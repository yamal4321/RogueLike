extends Node2D

var camera: Camera2D
var font

func draw_grid(x: float, y: float, cell_width: float, cell_height: float, n: int) -> void:
	for i in range(n + 1):  
		var line_x = x + i * cell_width
		draw_line(Vector2(line_x, y), Vector2(line_x, y + n * cell_height), Color.WHITE)

	for j in range(n + 1):  
		var line_y = y + j * cell_height
		draw_line(Vector2(x, line_y), Vector2(x + n * cell_width, line_y), Color.WHITE)

func _draw():
	var tilemap = $TileMap
	var rect = tilemap.get_used_rect()
	draw_grid(40*rect.position.x, 40*rect.position.y, 40, 40, 30)

func _process(delta):
	queue_redraw()
