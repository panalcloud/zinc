tests
testSingleLineData
	self
		assert: (self textOf: (ZnServerSentEvent data: 'hello'))
		equals: (self wire: 'data: hello\n\n')