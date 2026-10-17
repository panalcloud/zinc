initialization
initialize
	super initialize.
	data := WriteStream on: (String new: 80).
	skipLf := false.
	atStart := true