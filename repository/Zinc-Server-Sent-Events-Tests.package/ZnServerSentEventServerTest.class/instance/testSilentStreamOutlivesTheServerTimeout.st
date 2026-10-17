tests
testSilentStreamOutlivesTheServerTimeout
	"Even without keep-alive, nothing on the server side reads, so the read timeout never fires"

	| response |
	server timeout: 1.
	self serve: (self handler: [ :stream |
		stream waitFor: ZnServerSentEventDoorbell new atMost: 2500 milliSeconds.
		stream sendData: 'after silence' ]).
	response := self get: 'events'.
	self assert: (self readerOn: response) next data equals: 'after silence'