tests
testCommentsGoToTheHandler
	| reader comments events |
	comments := OrderedCollection new.
	reader := self readerOn: ':\n\n: ping\ndata: x\n: two\n\n'.
	reader commentHandler: [ :each | comments add: each ].
	events := reader upToEnd.
	self assert: comments asArray equals: #( '' 'ping' 'two' ).
	self assert: events size equals: 1.
	self assert: events first data equals: 'x'