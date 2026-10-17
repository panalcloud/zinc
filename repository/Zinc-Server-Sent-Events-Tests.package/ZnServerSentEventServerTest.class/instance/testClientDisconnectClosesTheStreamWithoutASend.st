tests
testClientDisconnectClosesTheStreamWithoutASend
	"A watcher notices the closed connection while the handler sends nothing"

	| closed response start elapsed |
	closed := Semaphore new.
	self serve: (self handler: [ :stream |
		stream sendData: 'first'.
		[ stream isOpen ] whileTrue: [ (Delay forMilliseconds: 5) wait ].
		closed signal ]).
	response := self get: 'events'.
	self assert: (self readerOn: response) next data equals: 'first'.
	start := Time millisecondClockValue.
	clients removeFirst close.
	self assert: (closed waitTimeoutSeconds: 2) not.
	elapsed := Time millisecondsSince: start.
	self assert: elapsed < 500