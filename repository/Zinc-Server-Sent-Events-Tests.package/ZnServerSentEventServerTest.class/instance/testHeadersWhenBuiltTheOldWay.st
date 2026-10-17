tests
testHeadersWhenBuiltTheOldWay
	"Code that builds the response field by field, as ZnServerSentEventDelegate did, gets the same headers"

	| handler response |
	handler := self handler: [ :stream | ].
	server delegate: (ZnValueDelegate with: [ :request |
		ZnServerSentEventResponse new
			statusLine: ZnStatusLine ok;
			headers: ZnHeaders defaultResponseHeaders;
			handler: handler;
			setContentType: ZnServerSentEvent mimeType;
			yourself ]).
	response := self get: 'events'.
	self assert: response contentType printString equals: 'text/event-stream;charset=utf-8'.
	self assert: (response headers at: 'Cache-Control') equals: 'no-cache'.
	self assert: (response headers at: 'X-Accel-Buffering') equals: 'no'