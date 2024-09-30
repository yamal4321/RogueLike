extends Node2D


# Get the TileMap node
var tilemap = $TileMap

# Get the TileSet associated with the TileMap
var tile_set = tilemap.tile_set

func _ready():
	# Create an array to store texture data
	var texture_data = []

	# Loop through all the cells that have tiles in the TileMap
	for cell_pos in tilemap.get_used_cells():
		var tile_id = tilemap.get_cell(cell_pos)
		
		# If the tile exists in the tile set
		if tile_id != -1:
			# Get the tile texture
			var texture = tile_set.get_texture(tile_id)
			
			# Get the texture coordinates (in tile map coordinates)
			var tex_coords = tilemap.map_to_world(cell_pos)
			
			# Store the texture and coordinates in the array
			texture_data.append({"texture": texture, "coords": tex_coords})

	# Now texture_data contains all the textures and their corresponding coordinates
