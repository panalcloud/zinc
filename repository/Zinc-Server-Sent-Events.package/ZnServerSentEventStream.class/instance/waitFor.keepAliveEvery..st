waiting
waitFor: aDoorbell keepAliveEvery: aDuration
	"Wait until aDoorbell rings, sending an empty comment each time aDuration passes without a ring.
	Answer true when rung, false when I am closed."

	[ isOpen ] whileTrue: [
		(self waitFor: aDoorbell atMost: aDuration)
			ifTrue: [ ^ true ].
		self sendComment: '' ].
	^ false