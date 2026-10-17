tests
testRingWakesTheHandlerAtOnce
	| bell response reader elapsed |
	bell := ZnServerSentEventDoorbell new.
	self serve: (self handler: [ :stream | | start |
		stream sendData: 'ready'.
		start := Time millisecondClockValue.
		(stream waitFor: bell keepAliveEvery: 10 seconds)
			ifTrue: [ stream sendData: (Time millisecondsSince: start) printString ] ]).
	response := self get: 'events'.
	reader := self readerOn: response.
	self assert: reader next data equals: 'ready'.
	bell ring.
	elapsed := reader next data asNumber.
	self assert: elapsed < 500