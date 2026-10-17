tests
testLineEnds
	| events |
	events := self eventsIn: 'data: a\ndata: b\n\ndata: c\r\ndata: d\r\n\r\ndata: e\rdata: f\r\r'.
	self
		assert: (events collect: [ :each | each data ]) asArray
		equals: { self wire: 'a\nb'. self wire: 'c\nd'. self wire: 'e\nf' }