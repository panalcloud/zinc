testing
isServerStopped
	^ server notNil and: [ server isRunning not ]