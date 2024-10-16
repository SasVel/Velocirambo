extends Node3D

@onready var isAiming : bool
@onready var activeTargetIdx : int = 0 :
	set(idx):
		activeTargets = get_children().filter(func(trg): return trg.targetIdx == idx)
		activeTargetIdx = idx
var activeTargets : Array[Node]
var enabled : bool = true :
	set(val):
		for target in activeTargets:
			_config_target(target, val)
			if isAiming: target.visible = val
		enabled = val

func _ready():
	config_targets_from_idx(activeTargetIdx)

func _on_anky_boss_boss_stage_changed(stageIdx):
	config_targets_from_idx(stageIdx - 1)

func _input(event):
	if event.is_action_pressed("Aim"):
		isAiming = true
		for target in activeTargets:
			target.visible = true
	elif event.is_action_released("Aim"):
		isAiming = false
		for target in activeTargets:
			target.visible = false

func config_targets_from_idx(targetIdx):
	for target in activeTargets: target.visible = false
	activeTargetIdx = targetIdx
	for target in get_children():
		_config_target(target, target.targetIdx == activeTargetIdx)

func _config_target(target, enabled):
	target.enabled = enabled
