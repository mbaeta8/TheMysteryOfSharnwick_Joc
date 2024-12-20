extends TileMap


var gridSize = 32;
var Dic = {}

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#for x in gridSize:
		#for y in gridSize:
			#Dic[str(Vector2(x,y))] = {
					#"Type": "Floor"
			#}
			#set_cell(0, Vector2(x,y), 0, Vector2(0,0), 0)
		#print(Dic)
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#var tile = local_to_map(get_global_mouse_position())
		#
	#if Dic.has(str(tile)):
		#set_cell(1)
		#set_cell(1, tile, 1, Vector2(0,0), 0)
		#print(Dic[str(tile)])
