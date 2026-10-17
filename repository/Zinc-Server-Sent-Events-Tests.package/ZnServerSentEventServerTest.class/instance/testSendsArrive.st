tests
testSendsArrive
	| results response reader comments events |
	self serve: (self handler: [ :stream |
		results := {
			stream sendEvent: 'a' data: 'one', String lf, 'two' id: '1'.
			stream sendComment: 'c'.
			stream sendRetry: 1000.
			stream sendData: 'plain' } ]).
	response := self get: 'events'.
	comments := OrderedCollection new.
	reader := (self readerOn: response) commentHandler: [ :each | comments add: each ]; yourself.
	events := reader upToEnd.
	self assert: results equals: #( true true true true ).
	self assert: (events collect: [ :each | each event ]) equals: #( 'a' nil ).
	self assert: (events collect: [ :each | each data ]) equals: { 'one', String lf, 'two'. 'plain' }.
	self assert: (events collect: [ :each | each id ]) equals: #( '1' '1' ).
	self assert: comments asArray equals: #( 'c' ).
	self assert: reader retry equals: 1000