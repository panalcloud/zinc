tests
testStatusDemoResumesAfterLastEventId
	| response event |
	self installDemo.
	response := self get: 'sse-status' with: [ :client | client headerAt: 'Last-Event-ID' put: '41' ].
	event := (self readerOn: response) next.
	self assert: event id equals: '42'.
	clients removeFirst close.
	self assert: self waitUntilNoOpenStreams equals: 0