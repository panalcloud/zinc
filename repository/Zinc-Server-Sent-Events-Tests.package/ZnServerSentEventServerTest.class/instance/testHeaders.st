tests
testHeaders
	| response |
	self serve: (self handler: [ :stream | ]).
	response := self get: 'events'.
	self assert: response isSuccess.
	self assert: response contentType printString equals: 'text/event-stream;charset=utf-8'.
	self assert: (response headers at: 'Cache-Control') equals: 'no-cache'.
	self assert: (response headers at: 'X-Accel-Buffering') equals: 'no'.
	self deny: (response headers includesKey: 'Content-Length')