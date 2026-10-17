tests
testRunHandlerGetsTheConnection
	"Handlers with only the old #run: protocol keep working"

	| argument response |
	self serve: (self runHandler: [ :connection |
		argument := connection.
		(ZnServerSentEvent data: 'hello') writeOn: connection ]).
	response := self get: 'events'.
	self assert: (self readerOn: response) next data equals: 'hello'.
	self deny: (argument isKindOf: ZnServerSentEventStream)