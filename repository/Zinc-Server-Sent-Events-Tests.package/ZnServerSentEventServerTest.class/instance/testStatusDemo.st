tests
testStatusDemo
	| page response reader event |
	self installDemo.
	page := ZnClient new beOneShot; get: server localUrl / 'sse-status-client'.
	self assert: (page includesSubstring: 'EventSource').
	response := self get: 'sse-status'.
	reader := self readerOn: response.
	event := reader next.
	self assert: event event equals: 'status-update'.
	self assert: event id equals: '1'.
	self assert: (event data includesSubstring: 'memory').
	self assert: reader retry equals: 2000.
	clients removeFirst close.
	self assert: self waitUntilNoOpenStreams equals: 0