tests
testNoProcessIsLeftBehind
	| response |
	self serve: (self handler: [ :stream | stream sendData: 'x' ]).
	response := self get: 'leftover'.
	response entity stream upToEnd.
	(Delay forMilliseconds: 200) wait.
	self assert: (self liveProcessesNamed: 'ZnServerSentEvent watcher /leftover') isEmpty