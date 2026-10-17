accessing
eventStreamMimeType
	^ ZnServerSentEvent mimeType copy
		setCharSetUTF8;
		yourself