tests
testHandlerErrorIsLoggedAndEndsTheStream
	| logged response |
	logged := OrderedCollection new.
	ZnLogEvent announcer when: ZnServerHandlerErrorEvent do: [ :each | logged add: each ] for: self.
	[ self serve: (self handler: [ :stream | Error signal: 'boom' ]).
	  response := self get: 'events'.
	  self assert: (self readerOn: response) next isNil ]
		ensure: [ ZnLogEvent announcer unsubscribe: self ].
	self assert: logged size equals: 1.
	self assert: logged first exception messageText equals: 'boom'