initialize-release
close
	"After close every send does nothing and answers false. Callable from any process; never waits for a send.
	The server closes the connection when the handler returns."

	self closeBecause: 'closed'.
	watcher ifNotNil: [ :process |
		watcher := nil.
		process == Processor activeProcess ifFalse: [ process terminate ] ]