private
handlerFailed: exception
	"Like the server does for request handlers: pass in debug mode, else log"

	| server |
	server := ZnCurrentServer value.
	(server isNil or: [ server debugMode ])
		ifTrue: [ ^ exception pass ].
	server logServerHandlerError: exception