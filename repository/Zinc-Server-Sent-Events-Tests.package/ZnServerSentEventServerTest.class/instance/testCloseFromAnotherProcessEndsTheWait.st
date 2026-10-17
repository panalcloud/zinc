tests
testCloseFromAnotherProcessEndsTheWait
	| bell opened ended theStream result elapsed response |
	bell := ZnServerSentEventDoorbell new.
	opened := Semaphore new.
	ended := Semaphore new.
	self serve: (self handler: [ :stream | | start |
		theStream := stream.
		opened signal.
		start := Time millisecondClockValue.
		result := stream waitFor: bell keepAliveEvery: 10 seconds.
		elapsed := Time millisecondsSince: start.
		ended signal ]).
	response := self get: 'events'.
	self assert: (opened waitTimeoutSeconds: 5) not.
	(Delay forMilliseconds: 50) wait.
	theStream close.
	self assert: (ended waitTimeoutSeconds: 2) not.
	self assert: result equals: false.
	self assert: elapsed < 500