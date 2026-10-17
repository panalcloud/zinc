tests
testEmptyLinesInDataAreKept
	self
		assert: (self textOf: (ZnServerSentEvent data: (self wire: 'a\n\nb\n')))
		equals: (self wire: 'data: a\ndata:\ndata: b\ndata:\n\n')