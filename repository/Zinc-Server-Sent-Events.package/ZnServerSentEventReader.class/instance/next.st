reading
next
	"Answer the next event a client would dispatch, or nil when the stream ends first.
	Blocks while the stream waits for input."

	| line event |
	[ (line := self nextLine) isNil ] whileFalse: [
		event := self processLine: line.
		event ifNotNil: [ ^ event ] ].
	^ nil