@tool
@icon("../icons/HighlightRenderer.svg")
extends Node
class_name HighlightRenderer

var updated : bool = true

## This should be set to the current camera.  The HighlightRenderer will disable the current camera and move the internal cameras to match it's location.
@export var camera : Camera3D

## The color the highlight should render
@export var highlightColor : Color = Color.YELLOW :
	set(val):
		print("triggytrigg")
		highlightColor = val
		updated = true
		
## The layer the internal highlight camera should render
@export_flags_3d_render var highlightRenderLayer = 1024 : 
	set(val):
		highlightRenderLayer = val
		updated = true

var renderPipelineScene : PackedScene = load("res://addons/COMS/nodes/HighlightRenderPipeline.tscn")
var renderPipeline : HighlightRenderPipeline

func _ready():
	renderPipeline = renderPipelineScene.instantiate()
	self.add_child(renderPipeline)
	camera.current = false
	
func _process(delta):
	renderPipeline.update_camera_transforms(camera)
	
	# Update during process for variables.
	# I was having issues with calling these functions in _ready().
	# TODO : investigate
	if updated:	
		updated = false
		renderPipeline.update_highlight_color(highlightColor)
		renderPipeline.update_highlight_layer(highlightRenderLayer)
