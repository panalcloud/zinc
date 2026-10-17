tests
testConstructors
	| event |
	event := ZnServerSentEvent type: 't' id: 'i' data: 'd'.
	self assert: event event equals: 't'; assert: event id equals: 'i'; assert: event data equals: 'd'.
	event := ZnServerSentEvent type: 't' data: 'd'.
	self assert: event event equals: 't'; assert: event id isNil; assert: event data equals: 'd'.
	event := ZnServerSentEvent id: 'i' data: 'd'.
	self assert: event event isNil; assert: event id equals: 'i'; assert: event data equals: 'd'.
	event := ZnServerSentEvent data: 'd'.
	self assert: event data equals: 'd'.
	self assert: ZnServerSentEvent mimeType equals: 'text/event-stream' asZnMimeType