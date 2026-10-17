tests
testKeepAliveWhileWaiting
	"Comments go out at the interval while nothing rings; a ring ends the wait"

	| bell response comments reader event |
	bell := ZnServerSentEventDoorbell new.
	self serve: (self handler: [ :stream |
		(stream waitFor: bell keepAliveEvery: 100 milliSeconds)
			ifTrue: [ stream sendData: 'rung' ] ]).
	response := self get: 'events'.
	comments := 0.
	reader := (self readerOn: response)
		commentHandler: [ :each | (comments := comments + 1) = 3 ifTrue: [ bell ring ] ];
		yourself.
	event := reader next.
	self assert: event data equals: 'rung'.
	self assert: comments equals: 3