tests
testPrintOn
	| event |
	event := ZnServerSentEvent type: 't' data: 'd'.
	event comment: 'c'.
	self assert: event printString equals: 'a ZnServerSentEvent(comment=c, event=t, data=d)'