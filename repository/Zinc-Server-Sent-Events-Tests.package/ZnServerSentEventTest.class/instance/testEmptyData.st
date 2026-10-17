tests
testEmptyData
	self
		assert: (self textOf: (ZnServerSentEvent data: ''))
		equals: (self wire: 'data:\n\n')