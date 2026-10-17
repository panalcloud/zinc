tests
testOpenStreamsAreCounted
	| bell opened ended deadline |
	bell := ZnServerSentEventDoorbell new.
	opened := Semaphore new.
	ended := Semaphore new.
	self assert: (ZnServerSentEventStream numberOfOpenStreamsFor: server) equals: 0.
	self serve: (self handler: [ :stream |
		opened signal.
		stream waitFor: bell keepAliveEvery: 10 seconds.
		ended signal ]).
	3 timesRepeat: [ self get: 'events' ].
	3 timesRepeat: [ self assert: (opened waitTimeoutSeconds: 5) not ].
	self assert: (ZnServerSentEventStream numberOfOpenStreamsFor: server) equals: 3.
	self assert: ((ZnServerSentEventStream openStreamsFor: server) allSatisfy: [ :each | each isOpen ]).
	clients do: [ :each | each close ].
	3 timesRepeat: [ self assert: (ended waitTimeoutSeconds: 2) not ].
	deadline := Time millisecondClockValue + 1000.
	[ (ZnServerSentEventStream numberOfOpenStreamsFor: server) > 0 and: [ Time millisecondClockValue < deadline ] ]
		whileTrue: [ (Delay forMilliseconds: 10) wait ].
	self assert: (ZnServerSentEventStream numberOfOpenStreamsFor: server) equals: 0