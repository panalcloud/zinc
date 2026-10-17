tests
testMultiLineComment
	self
		assert: (self textOf: (ZnServerSentEvent withComment: (self wire: 'one\r\ntwo\n')))
		equals: (self wire: ': one\n: two\n:\n\n')