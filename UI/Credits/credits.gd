extends MenuComponent

func _ready():
	focusedComponent = %BackBtn

func activate():
	super()
	self.visible = true

func deactivate():
	self.visible = false
	closed.emit(self)

func _on_back_btn_pressed():
	deactivate()
