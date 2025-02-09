extends Area3D

@onready var label_3d: Label3D = $Label3D
@onready var sub_viewport: SubViewport = $SubViewport
@onready var static_body_3d: StaticBody3D = $StaticBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func setup_scene(entity: OpenXRFbSpatialEntity) -> void:
	var semantic_labels: PackedStringArray = entity.get_semantic_labels()

	label_3d.text = semantic_labels[0]

	var collision_shape = entity.create_collision_shape()
	if collision_shape:
		add_child(collision_shape)
		static_body_3d.add_child(collision_shape)

	var mesh_instance: MeshInstance3D = entity.create_mesh_instance()
	if mesh_instance:
		var csg_mesh: CSGMesh3D = CSGMesh3D.new()
		csg_mesh.name = "WindowMesh"
		add_child(csg_mesh)
		print("Create WindowMesh")
		csg_mesh.mesh = mesh_instance.mesh
		csg_mesh.operation = CSGShape3D.OPERATION_SUBTRACTION
