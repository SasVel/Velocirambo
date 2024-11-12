extends Node
class_name UIHelper

@onready var yesNoMsgScn = preload("res://UI/Components/YesNoMessage/yes_no_message.tscn")

func show_yes_no_msg(caller : Control, message : String = "Are you sure?"):
	var msg : YesNoMessage = yesNoMsgScn.instantiate().init(message)
	caller.add_child(msg)
	
	var res = await msg.answer
	msg.queue_free()
	caller.set_focus()
	return res
