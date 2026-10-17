tests
testWaitAtMost
	"Without keep-alive: false on timeout, the stream stays open; true when rung"

	| bell ran results response |
	bell := ZnServerSentEventDoorbell new.
	ran := Semaphore new.
	self serve: (self handler: [ :stream |
		results := OrderedCollection new.
		results add: (stream waitFor: bell atMost: 100 milliSeconds); add: stream isOpen.
		bell ring.
		results add: (stream waitFor: bell atMost: 5 seconds).
		ran signal ]).
	response := self get: 'events'.
	self assert: (ran waitTimeoutSeconds: 5) not.
	self assert: results asArray equals: #( false true true )