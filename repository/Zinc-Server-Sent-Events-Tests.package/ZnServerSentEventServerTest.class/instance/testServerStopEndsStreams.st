tests
testServerStopEndsStreams
	"The default (managing) server closes its connections on stop; each watcher then closes its stream"

	| bell opened ended stopped elapsed |
	bell := ZnServerSentEventDoorbell new.
	opened := Semaphore new.
	ended := Semaphore new.
	self serve: (self handler: [ :stream |
		opened signal.
		stream waitFor: bell keepAliveEvery: 10 seconds.
		ended signal ]).
	3 timesRepeat: [ self get: 'events' ].
	3 timesRepeat: [ self assert: (opened waitTimeoutSeconds: 5) not ].
	stopped := Time millisecondClockValue.
	server stop.
	3 timesRepeat: [ self assert: (ended waitTimeoutSeconds: 2) not ].
	elapsed := Time millisecondsSince: stopped.
	self assert: elapsed < 500