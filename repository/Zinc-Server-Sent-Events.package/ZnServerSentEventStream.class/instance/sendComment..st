sending
sendComment: aString
	"A comment line, ignored by clients; used as keep-alive"

	^ self send: (ZnServerSentEvent withComment: aString)