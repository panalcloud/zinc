tests
testComment
	self
		assert: (self textOf: (ZnServerSentEvent withComment: 'ping'))
		equals: (self wire: ': ping\n\n')