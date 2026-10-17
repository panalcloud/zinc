sending
send: anEvent
	"Write anEvent and flush. Answer true when written, false when I am or became closed.
	A network failure closes me instead of signalling. Callable from any process; sends are serialised."

	^ lock critical: [
		isOpen and: [
			[ anEvent writeOn: connection.
			  logEvents ifTrue: [ self log: 'wrote ', anEvent printString ].
			  true ]
				on: NetworkError
				do: [ :exception |
					self closeBecause: exception messageText.
					false ] ] ]