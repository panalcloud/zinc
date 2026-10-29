system startup
startUp: resuming
	"Our system startUp hook: start all servers we manage, in a process of their own.
	Not with deferred startup actions: those run in the process that sent the save,
	which may end before it runs them (a server cancelling it on shutDown:),
	and then no server starts again. Errors in the process still open a debugger."

	(resuming or: [ self alwaysRestart ])
		ifTrue: [
			[ self managedServers do: [ :each | each start ] ]
				forkAt: Processor userSchedulingPriority
				named: 'ZnServer startUp' ]