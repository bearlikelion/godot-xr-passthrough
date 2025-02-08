extends OpenXRFbSceneManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().transparent_bg = true
	openxr_fb_scene_data_missing.connect(_scene_data_missing)
	openxr_fb_scene_capture_completed.connect(_scene_capture_completed)


func _scene_data_missing() -> void:
	request_scene_capture()


func _scene_capture_completed(success: bool) -> void:
	if success == false:
		return

   # Delete any existing anchors, since the user may have changed them.
	if are_scene_anchors_created():
		remove_scene_anchors()

	# Create scene_anchors for the freshly captured scene
	create_scene_anchors()
