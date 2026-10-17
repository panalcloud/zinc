tests
testPlainServerStopEndsStreamsWithinOneKeepAlive
	"ZnMultiThreadedServer does not track connections, so the stream notices the stop at its next keep-alive"

	| plainServer bell opened ended stopped elapsed handler |
	plainServer := ZnMultiThreadedServer on: 21000 + 1000 atRandom.
	bell := ZnServerSentEventDoorbell new.
	opened := Semaphore new.
	ended := Semaphore new.
	handler := self handler: [ :stream |
		opened signal.
		stream waitFor: bell keepAliveEvery: 200 milliSeconds.
		ended signal ].
	plainServer delegate: (ZnValueDelegate with: [ :request | ZnServerSentEventResponse request: request handler: handler ]).
	[ plainServer start.
	  clients add: (ZnClient new url: plainServer localUrl; addPath: 'events'; streaming: true; timeout: 5; get; yourself).
	  self assert: (opened waitTimeoutSeconds: 5) not.
	  stopped := Time millisecondClockValue.
	  plainServer stop.
	  self assert: (ended waitTimeoutSeconds: 2) not.
	  elapsed := Time millisecondsSince: stopped ]
		ensure: [ plainServer stop ].
	self assert: elapsed < 400