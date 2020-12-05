tool
extends Spatial

export var seed_val := 0 setget set_seedval
onready var noise_generator = $Viewport/NoiseGenerator
onready var viewport = $Viewport
onready var mesh =$GroundTexture
onready var collision = $StaticBody/CollisionShape

func set_seedval(val):
	seed_val = val
	if noise_generator != null:
		noise_generator.seed_val = val
		noise_generator.noise_configure()
		print(noise_generator.seed_val)
	
export var octaves := 3 setget set_octaves
func set_octaves(val):
	octaves = val
	if noise_generator != null:
		noise_generator.octaves = val
		noise_generator.noise_configure()
	
export var period := 20.0 setget set_period
func set_period(val):
	period = val
	if noise_generator != null:
		noise_generator.period = val
		noise_generator.noise_configure()
	
export var persistence := 0.8 setget set_persistence
func set_persistence(val):
	persistence = val
	if noise_generator != null:
		noise_generator.persistence = val
		noise_generator.noise_configure()
	
export var lacunarity := 2.0 setget set_lacunarity
func set_lacunarity(val):
	lacunarity = val
	if noise_generator != null:
		noise_generator.lacunarity = val
		noise_generator.noise_configure()
	
export var height_scale := 1.0 setget set_height_scale
func set_height_scale(val):
	height_scale = val
	if mesh != null:
		mesh.mesh.material.set_shader_param("height_scale", height_scale)

func _physics_process(delta):
	if viewport != null:
		var noise_texture = viewport.get_texture()
		mesh.mesh.material.set_shader_param("texture_noise", noise_texture)
		collision.shape.map_data = noise_generator.map_data
	
	if Input.is_action_pressed("ui_up"):
		noise_generator.offset_y += 0.1
	if Input.is_action_pressed("ui_down"):
		noise_generator.offset_y -= 0.1
	if Input.is_action_pressed("ui_left"):
		noise_generator.offset_x += 0.1
	if Input.is_action_pressed("ui_right"):
		noise_generator.offset_x -= 0.1
