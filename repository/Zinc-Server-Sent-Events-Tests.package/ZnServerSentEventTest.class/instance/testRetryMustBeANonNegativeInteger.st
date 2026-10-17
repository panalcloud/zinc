tests
testRetryMustBeANonNegativeInteger
	#( -1 1.5 '100' ) do: [ :each |
		self should: [ ZnServerSentEvent retry: each ] raise: ZnInvalidServerSentEvent ].
	self assert: (ZnServerSentEvent retry: 0) retry equals: 0.
	self assert: (ZnServerSentEvent new retry: nil; yourself) retry isNil