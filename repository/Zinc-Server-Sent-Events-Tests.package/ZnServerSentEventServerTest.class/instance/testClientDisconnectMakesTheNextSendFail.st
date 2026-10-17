tests
testClientDisconnectMakesTheNextSendFail
	"No exception reaches the handler; a send answers false and the handler ends normally"

	| ended sent lastResult endedNormally response |
	ended := Semaphore new.
	sent := 0.
	self serve: (self handler: [ :stream |
		[ stream sendData: 'first'.
		  [ (lastResult := stream sendData: 'more') and: [ sent < 1000 ] ]
			whileTrue: [ sent := sent + 1. (Delay forMilliseconds: 10) wait ].
		  endedNormally := true ] ensure: [ ended signal ] ]).
	response := self get: 'events'.
	self assert: (self readerOn: response) next data equals: 'first'.
	clients removeFirst close.
	self assert: (ended waitTimeoutSeconds: 2) not.
	self assert: endedNormally equals: true.
	self assert: lastResult equals: false.
	self assert: sent < 1000