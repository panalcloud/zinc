sending
sendRetry: milliseconds
	"Tell the client how long to wait before it reconnects"

	^ self send: (ZnServerSentEvent retry: milliseconds)