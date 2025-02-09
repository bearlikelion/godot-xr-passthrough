extends Area3D

const SHADOW_MATERIAL = preload("res://Materials/shadow_material.tres")
const WINDOW_FRAME = preload("res://Scenes/XR/MR/window_frame.tscn")
const WALL_FACE = preload("res://Scenes/XR/MR/wall_face.tscn")

var window_mesh: StaticBody3D = WINDOW_FRAME.instantiate()
var wall_mesh: StaticBody3D = WALL_FACE.instantiate()

@onready var label_3d: Label3D = $Label3D

func _ready() -> void:
	pass

func setup_scene(entity: OpenXRFbSpatialEntity) -> void:
	var semantic_labels: PackedStringArray = entity.get_semantic_labels()

	label_3d.text = semantic_labels[0]

	var collision_shape: CollisionShape3D = entity.create_collision_shape()
	add_child(collision_shape)

	if semantic_labels[0] == "wall_face":
		print("ADD WALL")
		add_child(wall_mesh)
		wall_mesh.name = "WallMesh"
		var bounding_size = entity.get_bounding_box_2d().size
		wall_mesh.csg_box_3d.size = Vector3(bounding_size.x, bounding_size.y, 0.1)
		var static_shape: CollisionShape3D = entity.create_collision_shape()
		wall_mesh.add_child(static_shape)

	if semantic_labels[0] == "window_frame":
		print("ADD WINDOW")
		add_child(window_mesh)
		window_mesh.name = "WindowMesh"
		var bounding_size = entity.get_bounding_box_2d().size
		window_mesh.csg_box_3d.size = Vector3(bounding_size.x, bounding_size.y, 10)
		var static_shape: CollisionShape3D = entity.create_collision_shape()
		window_mesh.add_child(static_shape)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("window"):
		print("REPARENT WINDOW")
		body.csg_box_3d.reparent(wall_mesh.csg_box_3d)
