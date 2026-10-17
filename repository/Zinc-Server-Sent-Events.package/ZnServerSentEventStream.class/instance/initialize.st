initialization
initialize
	super initialize.
	lock := Mutex new.
	isOpen := true