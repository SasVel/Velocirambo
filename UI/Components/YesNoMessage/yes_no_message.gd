extends MenuComponent
class_name YesNoMessage

##A message box that waits for an answer and returns it in a signal.

var message 

signal answer(value : bool)

func init(msg : String = "Are you sure?"):
	message = msg
	return self

func _ready():
	focusedComponent = %YesBtn
	activate()

func activate():
	super()
	%MessageLabel.text = message

func _on_yes_btn_pressed():
	answer.emit(true)

func _on_no_btn_pressed():
	answer.emit(false)
