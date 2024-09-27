extends Area3D

##A hitbox component designed to follow a bone from a boss mob's Skeleton3D
##The follow is executed in local space, so making the hitbox a direct child of the skeleton is advised.

@export var skeleton : Skeleton3D
@export var boneName : String
@export var stats : Stats
@onready var boneIdx = skeleton.find_bone(boneName)
##Multiplier for the damage value in the stats component
@export_range(1, 5) var dmgMultiplier = 1.5

func _physics_process(_delta):
	var boneTransform = skeleton.get_bone_global_pose(boneIdx)
	self.transform = boneTransform

func _on_area_entered(area):
	area.hit(stats.damage * dmgMultiplier)
