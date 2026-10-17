accessing
path
	"The request path, for process names and log lines"

	^ request
		ifNil: [ '?' ]
		ifNotNil: [ request uri pathPrintString ]