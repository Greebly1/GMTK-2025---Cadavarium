extends Node

# This script contains a slew of strategies (mostly locating certain nodes)
# it has been abstracted to this centralized location so we minimize code duplication, and have a centralized place to change the strategy when we need to refactor our game's architecture

func LocateCamera() -> Camera3D:
	return get_viewport().get_camera_3d()
