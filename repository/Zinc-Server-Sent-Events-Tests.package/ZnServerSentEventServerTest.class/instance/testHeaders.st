tests
testHeaders
	| response headers |
	self serve: (self handler: [ :stream | ]).
	response := self get: 'events'.
	self assert: response isSuccess.
	self assert: response contentType printString equals: 'text/event-stream;charset=utf-8'.
	self assert: (response headers at: 'Cache-Control') equals: 'no-cache'.
	self assert: (response headers at: 'X-Accel-Buffering') equals: 'no'.
	headers := self rawHeadersOf: 'events'.
	self assert: (headers at: 'Content-Type') equals: 'text/event-stream;charset=utf-8'.
	self deny: (headers includesKey: 'Content-Length').
	self deny: (headers includesKey: 'Transfer-Encoding')