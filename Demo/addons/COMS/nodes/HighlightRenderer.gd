@tool
@icon("../icons/HighlightRenderer.svg")
extends Node
class_name HighlightRenderer

## This should be set to the current camera.  The HighlightRenderer will disable the current camera and move the internal cameras to match it's location.
@export var camera : Camera3D
		
## The layer the internal highlight camera should render
@export_flags_3d_render var highlightRenderLayer = 1024

var renderPipelineScene : PackedScene = load("res://addons/COMS/nodes/HighlightRenderPipeline.tscn")
var renderPipeline : HighlightRenderPipeline

func _ready():
	HighlightCoordinator.set_active(self)
	
	# Instance the highlightRenderPipeline scene and configure the properties
	renderPipeline = renderPipelineScene.instantiate()
	self.add_child(renderPipeline)
	renderPipeline.update_highlight_layer(highlightRenderLayer)
	
	camera.current = false
	
## Update the color the highlight is rendering
func update_highlight_color(highlightColor : Color):
	renderPipeline.update_highlight_color(highlightColor)

func _process(delta):
	# Update the transforms of the internal cameras to match the external camera
	if renderPipeline:
		renderPipeline.update_camera_transforms(camera)
