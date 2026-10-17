tests
testClassCommentIsUntouched
	"The comment constructor must not be Class>>#comment:"

	| before |
	before := ZnServerSentEvent comment.
	ZnServerSentEvent withComment: 'x'.
	self assert: ZnServerSentEvent comment equals: before