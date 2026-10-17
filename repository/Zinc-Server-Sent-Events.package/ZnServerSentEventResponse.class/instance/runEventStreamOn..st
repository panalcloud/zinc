private
runEventStreamOn: connection
	"Run the handler on a stream over connection, in this (the server's worker) process,
	renamed after the request path meanwhile. A handler error is logged as a server handler error."

	| stream process name |
	stream := ZnServerSentEventStream on: connection request: request.
	process := Processor activeProcess.
	name := process name.
	process name: 'ZnServerSentEvent ', stream path.
	[ [ stream open.
	    handler runEventStream: stream ]
		on: Error
		do: [ :exception | self handlerFailed: exception ] ]
			ensure: [
				stream close.
				process name: name ]