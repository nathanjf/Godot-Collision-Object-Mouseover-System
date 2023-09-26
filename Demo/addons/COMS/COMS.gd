@tool
extends EditorPlugin

func _enter_tree():
	# Add to autoloads
	add_autoload_singleton("HighlightCoordinator", "res://addons/COMS/global/HighlightCoordinator.gd")
	print("COMS loaded")

func _exit_tree():
	# Remove from autoloads
	remove_autoload_singleton("HighlightCoordinator")
