tests
testCrAtTheEndDoesNotWaitForMoreInput
	"A CR ends the line at once; the reader must not need the next character to know that"

	| input reader |
	input := ReadStream on: (self wire: 'data: x\r\r') utf8Encoded.
	reader := ZnServerSentEventReader on: input.
	self assert: reader next data equals: 'x'.
	self assert: input atEnd