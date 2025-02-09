extends Node3D

const SUBVIEWPORT_MATERIAL = preload("res://Scenes/XR/MetaScene/subviewport_material.tres")

@onready var label_3d: Label3D = $Label3D
@onready var sub_viewport: SubViewport = $SubViewport


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func setup_scene(entity: OpenXRFbSpatialEntity) -> void:
	var semantic_labels: PackedStringArray = entity.get_semantic_labels()

	label_3d.text = semantic_labels[0]

	var collision_shape = entity.create_collision_shape()
	if collision_shape:
		add_child(collision_shape)

	var mesh_instance: MeshInstance3D = entity.create_mesh_instance()
	if mesh_instance:
		add_child(mesh_instance)
		var material = StandardMaterial3D.new()
		material.resource_local_to_scene = true
		material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		# var viewport_texture: ViewportTexture = ViewportTexture.new()
		# viewport_texture.viewport_path = ^'../SubViewport'
		material.albedo_texture = sub_viewport.get_texture()
		mesh_instance.material_override = material

		var viewport_camera: Camera3D = Camera3D.new()
		mesh_instance.add_child(viewport_camera)
