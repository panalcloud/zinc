waiting
waitFor: aDoorbell keepAliveEvery: aDuration
	"Wait until aDoorbell rings, sending an empty comment each time aDuration passes without a ring.
	Answer true when rung, false when I am closed. A stopped server closes me at the next keep-alive,
	for servers that do not close their connections when they stop."

	[ isOpen ] whileTrue: [
		(self waitFor: aDoorbell atMost: aDuration)
			ifTrue: [ ^ true ].
		self isServerStopped
			ifTrue: [ self closeBecause: 'server stopped' ]
			ifFalse: [ self sendComment: '' ] ].
	^ false