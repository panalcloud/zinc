testing
testStartUpRestartsServersWithoutTheCallerProcess
	"A save runs the session's deferred startup actions in the process that sent it, which may be gone by then. startUp: must restart the managed servers on its own and leave nothing queued there."

	| server savedAlwaysRestart deferred queued start |
	savedAlwaysRestart := ZnServer alwaysRestart.
	server := ZnServer on: self port.
	[
	server register; start.
	self assert: server isRunning.
	ZnServer alwaysRestart: true.
	ZnServer shutDown: false.
	self deny: server isRunning.
	deferred := SessionManager default currentSession instVarNamed: 'deferredStartupActions'.
	queued := deferred size.
	ZnServer startUp: false.
	self assert: deferred size equals: queued.
	start := Time millisecondClockValue.
	[ server isRunning or: [ (Time millisecondsSince: start) > 5000 ] ] whileFalse: [ (Delay forMilliseconds: 50) wait ].
	self assert: server isRunning ] ensure: [
		server stop.
		ZnServer alwaysRestart: savedAlwaysRestart ]