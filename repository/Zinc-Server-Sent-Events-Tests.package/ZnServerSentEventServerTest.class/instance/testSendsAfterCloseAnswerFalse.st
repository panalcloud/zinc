tests
testSendsAfterCloseAnswerFalse
	| results response |
	self serve: (self handler: [ :stream |
		stream close.
		results := { stream isOpen. stream sendData: 'x'. stream sendComment: 'c'. stream sendRetry: 1. stream sendEvent: 'e' data: 'd' id: nil } ]).
	response := self get: 'events'.
	self assert: response entity stream upToEnd isEmpty.
	self assert: results equals: #( false false false false false )