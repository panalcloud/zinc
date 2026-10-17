tests
testWatcherIsNamed
	| ran names |
	ran := Semaphore new.
	self serve: (self handler: [ :stream |
		names := (self liveProcessesNamed: 'ZnServerSentEvent watcher /watched') size.
		ran signal ]).
	self get: 'watched'.
	self assert: (ran waitTimeoutSeconds: 5) not.
	self assert: names equals: 1