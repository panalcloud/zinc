tests
testOnlyOneSpaceAfterTheColonIsRemoved
	| events |
	events := self eventsIn: 'data:x\n\ndata: x\n\ndata:  x\n\n'.
	self assert: (events collect: [ :each | each data ]) asArray equals: #( 'x' 'x' ' x' )