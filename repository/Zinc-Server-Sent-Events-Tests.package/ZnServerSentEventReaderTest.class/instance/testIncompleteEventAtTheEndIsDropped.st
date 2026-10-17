tests
testIncompleteEventAtTheEndIsDropped
	| reader |
	reader := self readerOn: 'data: a\n\ndata: b\n'.
	self assert: reader next data equals: 'a'.
	self assert: reader next isNil.
	self assert: reader atEnd