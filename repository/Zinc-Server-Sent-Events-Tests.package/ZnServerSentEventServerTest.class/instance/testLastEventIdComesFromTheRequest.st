tests
testLastEventIdComesFromTheRequest
	| ran lastEventId |
	ran := Semaphore new.
	self serve: (self handler: [ :stream |
		lastEventId := stream lastEventId.
		ran signal ]).
	self get: 'events' with: [ :client | client headerAt: 'Last-Event-ID' put: '42' ].
	self assert: (ran waitTimeoutSeconds: 5) not.
	self assert: lastEventId equals: '42'