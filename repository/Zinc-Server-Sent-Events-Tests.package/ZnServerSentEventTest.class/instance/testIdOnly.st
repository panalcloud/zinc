tests
testIdOnly
	self
		assert: (self textOf: (ZnServerSentEvent new id: '12'; yourself))
		equals: (self wire: 'id: 12\n\n')