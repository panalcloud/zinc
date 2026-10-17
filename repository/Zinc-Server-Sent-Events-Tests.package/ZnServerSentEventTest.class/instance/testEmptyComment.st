tests
testEmptyComment
	"The shortest keep-alive"

	self
		assert: (self textOf: (ZnServerSentEvent withComment: ''))
		equals: (self wire: ':\n\n')