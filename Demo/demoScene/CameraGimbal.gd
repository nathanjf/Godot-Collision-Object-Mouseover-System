extends Node3D

@export var radsPerSecond : float = 2 * PI / 10

func _process(delta):
	self.rotation.y += radsPerSecond * delta
