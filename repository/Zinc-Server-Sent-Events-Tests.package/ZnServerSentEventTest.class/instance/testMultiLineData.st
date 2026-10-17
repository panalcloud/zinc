tests
testMultiLineData
	self
		assert: (self textOf: (ZnServerSentEvent data: (self wire: 'a\nb\r\nc\rd')))
		equals: (self wire: 'data: a\ndata: b\ndata: c\ndata: d\n\n')