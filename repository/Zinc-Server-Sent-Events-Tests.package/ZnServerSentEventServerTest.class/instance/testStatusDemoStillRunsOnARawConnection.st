tests
testStatusDemoStillRunsOnARawConnection
	"Code that calls the demo handler's #run: directly keeps working"

	| response |
	server delegate: (ZnValueDelegate with: [ :request |
		ZnServerSentEventResponse request: request handler: (self runHandler: [ :connection |
			[ ZnServerSentEventStatusHandler new run: connection ]
				on: ConnectionClosed, ConnectionTimedOut
				do: [ ] ]) ]).
	response := self get: 'events'.
	self assert: (self readerOn: response) next event equals: 'status-update'