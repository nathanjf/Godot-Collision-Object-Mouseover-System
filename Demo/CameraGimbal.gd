extends Node3D

@export var radsPerSecond : float = 2 * PI / 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rotation.y += radsPerSecond * delta
