tests
testEventsAreLoggedOnlyWhenAsked
	| logged response |
	logged := OrderedCollection new.
	ZnLogEvent announcer when: ZnLogEvent do: [ :each | logged add: each printString ] for: self.
	[ self serve: (self handler: [ :stream |
		stream sendData: 'quiet'.
		stream logEvents: true.
		stream sendData: 'loud' ]).
	  response := self get: 'events'.
	  response entity stream upToEnd ]
		ensure: [ ZnLogEvent announcer unsubscribe: self ].
	self deny: (logged anySatisfy: [ :each | each includesSubstring: 'quiet' ]).
	self assert: (logged anySatisfy: [ :each | each includesSubstring: 'loud' ])