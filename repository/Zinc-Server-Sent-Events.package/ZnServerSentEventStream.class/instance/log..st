private
log: aString
	server ifNotNil: [ server logServerGeneric: 'SSE ', self path, ' ', aString ]