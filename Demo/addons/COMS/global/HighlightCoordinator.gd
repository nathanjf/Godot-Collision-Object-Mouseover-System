extends Node

## A reference to the currently active highlight renderer
var activeRenderer : HighlightRenderer

func set_active(renderer : HighlightRenderer):
	activeRenderer = renderer

func set_color(color : Color):
	if activeRenderer:
		activeRenderer.update_highlight_color(color)
		return
	print("COMS ERROR: No active renderer")
