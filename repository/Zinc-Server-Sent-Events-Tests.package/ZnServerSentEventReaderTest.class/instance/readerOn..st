private
readerOn: aString
	^ ZnServerSentEventReader on: (self wire: aString) utf8Encoded readStream