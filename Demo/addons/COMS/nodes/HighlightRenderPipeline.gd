@tool
extends SubViewportContainer
class_name HighlightRenderPipeline

@onready var highlightCamera : Camera3D = $%HighlightCamera
@onready var sceneCamera : Camera3D = $%SceneCamera

func update_camera_transforms(camera : Camera3D):
	highlightCamera.global_transform = camera.global_transform
	sceneCamera.global_transform = camera.global_transform

func update_highlight_layer(renderLayer : int) :
	highlightCamera.cull_mask = renderLayer

func update_highlight_color(color : Color):
	self.material.set_shader_parameter("color", color)	
