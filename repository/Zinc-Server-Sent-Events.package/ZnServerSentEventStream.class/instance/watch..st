private
watch: socket
	"Wait on the socket until the connection closes, then close me.
	A client sends nothing after its request; bytes that still come are read and dropped.
	Only this process reads the socket: the handler only writes, through the socket's write semaphore."

	[ isOpen ] whileTrue: [
		socket
			waitForDataFor: 60
			ifClosed: [ ^ self closeBecause: 'client went away' ]
			ifTimedOut: [ nil ].
		socket dataAvailable ifTrue: [ socket receiveAvailableData ] ]