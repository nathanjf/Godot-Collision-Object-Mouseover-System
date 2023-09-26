@tool
@icon("../icons/HighlightObject.svg")
extends Node
class_name HighlightObject

## A reference to the collision object in order to get the mouseover signal
@export var collisionObject : CollisionObject3D

## The root of where the MeshInstance3Ds for this object are contained
@export var meshParent : Node

## The color this object's highlight should be
@export var highlightColor : Color = Color.YELLOW

## The layer that highlights are being rendered to
@export_flags_3d_render var highlightRenderLayer = 1024
var meshes : Array[MeshInstance3D]

func _ready():
	collisionObject.connect("mouse_entered", _on_mouse_entered)
	collisionObject.connect("mouse_exited", _on_mouse_exited)
	update_meshes()
	
## Enable the render layer by ORing the bitmask
func _enable_render_layer(mesh : MeshInstance3D):
	mesh.layers = mesh.layers | highlightRenderLayer

## Disable the render layer by ANDing the inverse of the bitmask
func _disable_render_layer(mesh : MeshInstance3D):
	mesh.layers = mesh.layers & ~(highlightRenderLayer)

## Recursively add mesh instances to the mesh list
func update_meshes():
	# Disable renderlayer and delete old list
	for mesh in meshes:
		if is_instance_valid(mesh):
			_disable_render_layer(mesh)
	meshes.clear()
	
	# Push nodes to a stack and visit all their children
	var toVisit : Array[Node] = []
	toVisit.append(meshParent)
	while !toVisit.is_empty():
		var top = toVisit.pop_front()
		if top is MeshInstance3D:
			meshes.append(top)

		toVisit.append_array(top.get_children()) 

func _on_mouse_entered():
	for mesh in meshes:
		_enable_render_layer(mesh)
	HighlightCoordinator.set_color(self.highlightColor)
		
func _on_mouse_exited():
	for mesh in meshes:
		_disable_render_layer(mesh)
