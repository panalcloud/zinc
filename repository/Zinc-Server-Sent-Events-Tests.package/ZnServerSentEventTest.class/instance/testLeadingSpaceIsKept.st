tests
testLeadingSpaceIsKept
	"A client removes one space after the colon, so a value starting with a space needs one more"

	self
		assert: (self textOf: (ZnServerSentEvent data: ' x'))
		equals: (self wire: 'data:  x\n\n')