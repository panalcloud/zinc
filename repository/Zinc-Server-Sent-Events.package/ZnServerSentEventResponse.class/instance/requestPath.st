private
requestPath
	^ request
		ifNil: [ '?' ]
		ifNotNil: [ request uri pathPrintString ]