running
setUp
	super setUp.
	lock := Mutex new.
	handlersStarted := 0.
	handlersDone := Semaphore new.
	clients := OrderedCollection new.
	server := ZnServer on: 21000 + 1000 atRandom.
	server start