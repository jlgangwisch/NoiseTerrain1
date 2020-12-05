#There has got to be a better way to do this with a noise texture
tool
extends Node2D

var noise := OpenSimplexNoise.new()

var offset_x := 0.0
var offset_y := 0.0
var offset_z := 1.0


export var cellsize := 1;
export var speed_x := 0.01
export var speed_y := 0.01
export var speed_z := 0.01

var seed_val := 1
var octaves := 1
var period := 10
var persistence := 1
var lacunarity := 2.0

var map_data := PoolRealArray()
onready var viewport_size = get_viewport().get_visible_rect().size

func _ready():
	noise_configure()

func _physics_process(delta):

	offset_z += speed_z
	update()
	
	
func noise_configure():
	noise.seed = seed_val
	noise.octaves = octaves
	noise.period = period
	noise.persistence = persistence
	noise.lacunarity = lacunarity

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

func _draw():
	var float_array := PoolRealArray()
	for x in int(viewport_size.x/cellsize):
		for y in int(viewport_size.y/cellsize):
			var val = noise.get_noise_3d(x+offset_x, y+offset_y, offset_z) * 0.5 + 0.5
			float_array.append(val*20)
			var color = Color(val,val,val)
			var r = Rect2(x*cellsize, y*cellsize, cellsize, cellsize)
			draw_rect(r, color)
	map_data = float_array
