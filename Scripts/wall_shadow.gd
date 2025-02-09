extends Node3D

const SHADOW_MATERIAL = preload("res://Materials/shadow_material.tres")

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
		var csg_mesh: CSGMesh3D = CSGMesh3D.new()
		csg_mesh.name = "WallMesh"
		add_child(csg_mesh)
		print("Create WallMesh")
		csg_mesh.mesh = mesh_instance.mesh
		csg_mesh.material = SHADOW_MATERIAL
		csg_mesh.flip_faces = true
