tests
testNonStringValuesArePrinted
	self
		assert: (self textOf: (ZnServerSentEvent type: 'counter' id: 42 data: 100))
		equals: (self wire: 'event: counter\nid: 42\ndata: 100\n\n')