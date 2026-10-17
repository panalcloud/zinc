private
linesOf: string do: block
	"Evaluate block with each line of string. CR, LF and CRLF end a line.
	Empty lines are kept, so a trailing line end gives a last empty line."

	| in line |
	in := string readStream.
	line := WriteStream on: (String new: 64).
	[ in atEnd ] whileFalse: [ | char |
		char := in next.
		(char = Character cr or: [ char = Character lf ])
			ifTrue: [
				char = Character cr ifTrue: [ in peekFor: Character lf ].
				block value: line contents.
				line := WriteStream on: (String new: 64) ]
			ifFalse: [ line nextPut: char ] ].
	block value: line contents