running
tearDown
	clients do: [ :each | each close ].
	handlersStarted timesRepeat: [ handlersDone waitTimeoutSeconds: 5 ].
	server stop.
	super tearDown