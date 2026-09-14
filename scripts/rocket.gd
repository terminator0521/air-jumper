extends MultiMeshInstance2D

@export var frame_height  = 1
@export var frame_width = 2
@export var animation_speed = 0.5
@export var instance_count = 0
var frame
var total_frames
var current_frame = 0
var max_frame

func _ready() -> void:
	# Set instance count 
	multimesh.instance_count = instance_count
	
	# Check for all requirements being valid
	if texture == null or multimesh == null or multimesh.mesh == null:
		return
	
	# Get size of spritesheet
	var texture_size: Vector2 = texture.get_size() 
	
	# Get size of single sprite
	var frame_size = Vector2(	
		texture_size.x / float(frame_width),
		texture_size.y / float(frame_height)
	)
	
	#get single texture
	if multimesh.mesh is QuadMesh:
		multimesh.mesh.size = frame_size
		
	total_frames = frame_height * frame_width
	
	pass # Replace with function body.

func _process(delta: float) -> void:
	# Get frame time
	max_frame = total_frames * (1 / delta) * animation_speed
	
	# set frame
	if current_frame < max_frame:
		frame = 0
	else:
		frame += 1
		
	# Change frame
	for i in range(multimesh.instance_count):
		multimesh.set_instance_custom_data(i, Color(current_frame / total_frames, 0.0, 0.0, 0.0))
			
	pass
