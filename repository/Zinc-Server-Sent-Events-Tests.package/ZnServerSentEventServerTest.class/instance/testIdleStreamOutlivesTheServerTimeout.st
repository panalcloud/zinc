tests
testIdleStreamOutlivesTheServerTimeout
	"ZSSE-RSP3: the server's socket timeout (1 s here) does not close a stream that only writes now and then"

	| bell response reader |
	server timeout: 1.
	bell := ZnServerSentEventDoorbell new.
	self serve: (self handler: [ :stream |
		(stream waitFor: bell keepAliveEvery: 500 milliSeconds)
			ifTrue: [ stream sendData: 'still here' ] ]).
	response := self get: 'events'.
	reader := self readerOn: response.
	[ (Delay forMilliseconds: 2500) wait. bell ring ] fork.
	self assert: reader next data equals: 'still here'