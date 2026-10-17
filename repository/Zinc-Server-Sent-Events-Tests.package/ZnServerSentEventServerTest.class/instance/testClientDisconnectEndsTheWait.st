tests
testClientDisconnectEndsTheWait
	| bell ended result start elapsed response |
	bell := ZnServerSentEventDoorbell new.
	ended := Semaphore new.
	self serve: (self handler: [ :stream |
		stream sendData: 'ready'.
		result := stream waitFor: bell keepAliveEvery: 10 seconds.
		ended signal ]).
	response := self get: 'events'.
	self assert: (self readerOn: response) next data equals: 'ready'.
	start := Time millisecondClockValue.
	clients removeFirst close.
	self assert: (ended waitTimeoutSeconds: 2) not.
	elapsed := Time millisecondsSince: start.
	self assert: result equals: false.
	self assert: elapsed < 500