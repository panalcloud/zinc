private
evaluateWith: anObject
	test handlerStarted.
	^ [ block value: anObject ] ensure: [ test handlerEnded ]