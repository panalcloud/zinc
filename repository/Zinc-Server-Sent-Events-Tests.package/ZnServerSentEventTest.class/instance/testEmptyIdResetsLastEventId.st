tests
testEmptyIdResetsLastEventId
	self
		assert: (self textOf: (ZnServerSentEvent new id: ''; yourself))
		equals: (self wire: 'id:\n\n')