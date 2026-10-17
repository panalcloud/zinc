tests
testRetry
	| reader |
	reader := self readerOn: 'retry: 1500\n\n'.
	self assert: reader next isNil.
	self assert: reader retry equals: 1500.
	reader := self readerOn: 'retry: 1500\n\nretry: 15x\n\nretry:\n\n'.
	reader upToEnd.
	self assert: reader retry equals: 1500