tests
testEachEventIsFlushed
	"The first event reaches the client while the handler still waits"

	| go response first |
	go := Semaphore new.
	self serve: (self handler: [ :stream |
		stream sendData: 'first'.
		go waitTimeoutSeconds: 5.
		stream sendData: 'second' ]).
	response := self get: 'events'.
	first := (self readerOn: response) next.
	go signal.
	self assert: first data equals: 'first'