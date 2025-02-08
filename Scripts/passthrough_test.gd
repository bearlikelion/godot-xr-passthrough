extends XRToolsSceneBase

@onready var world_environment: WorldEnvironment = $WorldEnvironment

func _ready() -> void:
	super()
	_enable_passthrough(true)


func _enable_passthrough(enable: bool) -> void:
	var openxr_interface: OpenXRInterface = XRServer.find_interface("OpenXR")

	# Enable passthrough if true and XR_ENV_BLEND_MODE_ALPHA_BLEND is supported.
	# Otherwise, set environment to non-passthrough settings.
	if enable and openxr_interface.get_supported_environment_blend_modes().has(XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND):
		print("Enable Passthrough")
		get_viewport().transparent_bg = true
		world_environment.environment.background_mode = Environment.BG_COLOR
		world_environment.environment.background_color = Color(0.0, 0.0, 0.0, 0.0)
		openxr_interface.environment_blend_mode = XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND
		print("Color Passthrough: %s " % OpenXRFbPassthroughExtensionWrapper.has_color_passthrough_capability())
		print("Started: %s" % OpenXRFbPassthroughExtensionWrapper.is_passthrough_started())
		print("Supported: %s" % OpenXRFbPassthroughExtensionWrapper.is_passthrough_supported())
	else:
		print("Disable Passthrough")
		#get_viewport().transparent_bg = false
		#world_environment.environment.background_mode = Environment.BG_SKY
		#openxr_interface.environment_blend_mode = XRInterface.XR_ENV_BLEND_MODE_OPAQUE
