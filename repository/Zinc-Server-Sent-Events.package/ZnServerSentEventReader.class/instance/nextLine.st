private
nextLine
	"Answer the next line without its line end, or nil when the stream ends before one.
	CR, LF and CRLF end a line. After a CR the line is answered at once and a following LF is skipped later."

	| line char |
	atStart ifTrue: [
		atStart := false.
		(stream atEnd not and: [ stream peek = (Character value: 16rFEFF) ]) ifTrue: [ stream next ] ].
	line := WriteStream on: (String new: 80).
	[ stream atEnd ] whileFalse: [
		char := stream next.
		char ifNil: [ ^ nil ].
		(skipLf and: [ char = Character lf ])
			ifTrue: [ skipLf := false ]
			ifFalse: [
				skipLf := char = Character cr.
				(skipLf or: [ char = Character lf ]) ifTrue: [ ^ line contents ].
				line nextPut: char ] ].
	^ nil