extends MenuComponent

func activate():
	self.visible = true

func deactivate():
	self.visible = false
	closed.emit(self)

func _on_back_btn_pressed():
	deactivate()
