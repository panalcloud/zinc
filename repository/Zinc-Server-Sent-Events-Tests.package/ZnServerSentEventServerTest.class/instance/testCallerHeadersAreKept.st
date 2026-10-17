tests
testCallerHeadersAreKept
	| handler response |
	handler := self handler: [ :stream | ].
	server delegate: (ZnValueDelegate with: [ :request |
		(ZnServerSentEventResponse request: request handler: handler)
			in: [ :each |
				each headers
					at: 'X-Test' put: 'yes';
					at: 'Cache-Control' put: 'no-store' ];
			yourself ]).
	response := self get: 'events'.
	self assert: (response headers at: 'X-Test') equals: 'yes'.
	self assert: (response headers at: 'Cache-Control') equals: 'no-store'.
	self assert: (response headers at: 'X-Accel-Buffering') equals: 'no'