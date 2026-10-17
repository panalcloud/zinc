accessing
useConnection: connection
	"Hook method overwritten to give the receiver the chance to 
	keep using connection in the current thread/process after the server wrote the response.
	We pass control to our handler: with a ZnServerSentEventStream when it understands #runEventStream:,
	else with the raw connection through #run:."
	
	(handler respondsTo: #runEventStream:)
		ifTrue: [ ^ self runEventStreamOn: connection ].
	[ handler run: connection ]
		on: ConnectionClosed, ConnectionTimedOut
		do: [ "ignore" ]