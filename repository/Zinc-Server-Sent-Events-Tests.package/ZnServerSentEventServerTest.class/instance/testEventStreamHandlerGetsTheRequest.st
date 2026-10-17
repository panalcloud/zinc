tests
testEventStreamHandlerGetsTheRequest
	| ran request lastEventId |
	ran := Semaphore new.
	self serve: (self handler: [ :stream |
		request := stream request.
		lastEventId := stream lastEventId.
		ran signal ]).
	self get: 'events?x=1'.
	self assert: (ran waitTimeoutSeconds: 5) not.
	self assert: request uri pathPrintString equals: '/events'.
	self assert: (request uri queryAt: 'x') equals: '1'.
	self assert: lastEventId isNil