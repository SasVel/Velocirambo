extends Hitbox
class_name BossHitbox

##A hitbox component designed to follow a bone from a boss mob's Skeleton3D
##The follow is executed in local space, so making the hitbox a direct child of the skeleton is advised.

@export var skeleton : Skeleton3D
@export var boneName : String
@export var isFollowEnabled : bool = true
@onready var boneIdx : int

func _ready():
	if !isFollowEnabled: return
	boneIdx = skeleton.find_bone(boneName)

func _physics_process(_delta):
	if !isFollowEnabled: return
	var boneTransform = skeleton.get_bone_global_pose(boneIdx)
	self.transform = boneTransform
