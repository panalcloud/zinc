tests
testProcessIsNamedWhileStreaming
	| ran name |
	ran := Semaphore new.
	self serve: (self handler: [ :stream |
		name := Processor activeProcess name.
		ran signal ]).
	self get: 'events'.
	self assert: (ran waitTimeoutSeconds: 5) not.
	self assert: name equals: 'ZnServerSentEvent /events'