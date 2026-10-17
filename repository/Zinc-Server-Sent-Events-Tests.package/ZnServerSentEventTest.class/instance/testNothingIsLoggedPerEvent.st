tests
testNothingIsLoggedPerEvent
	| server logged |
	logged := OrderedCollection new.
	server := ZnServer on: 0.
	ZnLogEvent announcer when: ZnLogEvent do: [ :each | logged add: each ] for: self.
	[ ZnCurrentServer value: server during: [ self bytesOf: (ZnServerSentEvent data: 'x') ] ]
		ensure: [ ZnLogEvent announcer unsubscribe: self ].
	self assert: logged isEmpty