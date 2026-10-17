tests
testLastEventId
	| reader events |
	reader := self readerOn: 'id: 1\ndata: a\n\ndata: b\n\nid\ndata: c\n\nid: x', (String with: (Character value: 0)), 'y\ndata: d\n\n'.
	events := reader upToEnd.
	"the id stays for later events, an empty id resets it, an id with NUL is ignored"
	self assert: (events collect: [ :each | each id ]) asArray equals: #( '1' '1' '' '' ).
	self assert: reader lastEventId equals: ''