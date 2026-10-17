private
waitUntilNoOpenStreams
	| deadline |
	deadline := Time millisecondClockValue + 2000.
	[ (ZnServerSentEventStream numberOfOpenStreamsFor: server) > 0 and: [ Time millisecondClockValue < deadline ] ]
		whileTrue: [ (Delay forMilliseconds: 10) wait ].
	^ ZnServerSentEventStream numberOfOpenStreamsFor: server