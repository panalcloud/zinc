private
handlerStarted
	lock critical: [ handlersStarted := handlersStarted + 1 ]