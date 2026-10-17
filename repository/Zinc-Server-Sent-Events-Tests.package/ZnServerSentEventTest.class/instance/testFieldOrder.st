tests
testFieldOrder
	| event |
	event := ZnServerSentEvent type: 'update' id: '7' data: 'x'.
	event retry: 1500; comment: 'note'.
	self
		assert: (self textOf: event)
		equals: (self wire: ': note\nevent: update\nid: 7\nretry: 1500\ndata: x\n\n')