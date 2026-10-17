tests
testRetryOnly
	self
		assert: (self textOf: (ZnServerSentEvent retry: 3000))
		equals: (self wire: 'retry: 3000\n\n')