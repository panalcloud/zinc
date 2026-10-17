sending
sendData: aString
	^ self send: (ZnServerSentEvent data: aString)