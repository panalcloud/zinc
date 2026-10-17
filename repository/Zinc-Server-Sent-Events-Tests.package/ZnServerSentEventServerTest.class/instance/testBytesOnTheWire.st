tests
testBytesOnTheWire
	| response |
	self serve: (self handler: [ :stream |
		stream
			sendEvent: 'a' data: 'one', String crlf, 'two' id: '1';
			sendComment: 'c';
			sendRetry: 1000;
			sendData: 'plain' ]).
	response := self get: 'events'.
	self
		assert: response entity stream upToEnd utf8Decoded
		equals: ('event: a|id: 1|data: one|data: two||: c||retry: 1000||data: plain||' copyReplaceAll: '|' with: String lf)